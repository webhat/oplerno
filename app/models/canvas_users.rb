# Synchronizes with Canvas and is the link between it and the #User
# See #User
class CanvasUsers < ActiveRecord::Base
  extend CanvasModule

  after_save :canvas_sync

  belongs_to :user
  attr_accessible :avatar_url, :canvas_id, :locale, :username

  def self.after_commit(record)
    canvas_user = CanvasUsers.find_by_username(record.email)
    self.create! ({username: record.email}) if canvas_user.nil?
  end

  def self.update(canvas_user)
    self.connect_to_canvas_oauth if canvas.nil?
    begin
      user = User.find_by_email canvas_user['login_id']
    rescue
      puts $!.inspect, $@
    else
      this_canvas_user = CanvasUsers.new
      this_canvas_user.user = user
    ensure
      begin
        this_canvas_user.canvas_id = canvas_user['id']
        this_canvas_user.avatar_url = canvas_user['avatar_url'] if canvas_user.key?('avatar_url')
        this_canvas_user.username = canvas_user['login_id']
        this_canvas_user.save
      end unless this_canvas_user.nil?
    end
  end

  def self.update_all
    self.connect_to_canvas_oauth if canvas.nil?

    canvas.get('/api/v1/accounts/1/users').as_json.each do |canvas_user|
      update canvas.get "/api/v1/users/#{canvas_user['id']}/profile"
    end
  end

  def self.canvas
    self.connect_to_canvas_oauth
  end

  private
  def canvas_sync
    return unless canvas_id.nil?

    CanvasUsers.connect_to_canvas_oauth if CanvasUsers.canvas.nil?

    begin
      user = CanvasUsers.canvas.post('/api/v1/accounts/1/users', {'pseudonym[unique_id]' => username, 'communication_channel[address]' => username, 'communication_channel[type]' => 'email'})
    rescue => e
      # FIXME: Need to update this user here...
      puts $!.inspect, $@
    else
      CanvasUsers.update user
    end

  end
end
