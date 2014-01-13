class CanvasUsers < ActiveRecord::Base
  extend CanvasModule

  belongs_to :user
  attr_accessible :avatar_url, :canvas_id, :locale, :username

  def self.update(canvas_user)
    self.connect_to_canvas_oauth if canvas.nil?
    begin
      user = User.find_by_email canvas_user['login_id']
    rescue
      # Handle error
    else
      this_canvas_user = CanvasUsers.new
      this_canvas_user.user = user
    ensure
      begin
        this_canvas_user.canvas_id = canvas_user['id']
        this_canvas_user.avatar_url = canvas_user['avatar_url']
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
end
