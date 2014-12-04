# Synchronizes with Canvas and is the link between it and the #User
# See #User
class CanvasUsers < ActiveRecord::Base
  extend CanvasModule

  after_create :canvas_sync

  belongs_to :user
  attr_accessible :avatar_url, :locale, :username, :user # :canvas_id

	# @deprecated Don't use this
  def self.after_commit(record)
		logger.info 'CanvasUsers#after_commit deprecated'
    canvas_user = CanvasUsers.find_by_username(record.email)
    self.create! username: record.email if canvas_user.nil?
  end

	def self.update canvas_user
		user = User.find_by_email canvas_user['login_id']
		if user.nil?
			user = create_default_user canvas_user
		else
			user = self.set_user_names canvas_user, user
		end
		this_canvas_user = CanvasUsers.find_by_username canvas_user['login_id']
		if this_canvas_user.nil?
			this_canvas_user = CanvasUsers.new
		end
		this_canvas_user.user = user
		this_canvas_user.canvas_id = canvas_user['id']
		this_canvas_user.avatar_url = canvas_user['avatar_url'] if canvas_user.key?('avatar_url')
		this_canvas_user.username = canvas_user['login_id']
		this_canvas_user.save
		this_canvas_user
	end

	def self.set_user_names canvas_user, user
		last, first = canvas_user['sortable_name'].split(',')
		user.first_name = first if user.first_name.nil?
		user.last_name = last if user.last_name.nil?
		user.save!
		user
	end

	def self.create_default_user canvas_user
		generated_password = Devise.friendly_token.first(8)
		user = User.new email: canvas_user['login_id'], password: generated_password, password_confirmation: generated_password
		user.skip_confirmation!
		user.save!
		user
	end

  def self.update_all
    self.connect_to_canvas_oauth if canvas.nil?

    canvas.get('/api/v1/accounts/1/users?per_page=200').as_json.each do |canvas_user|
			CanvasUsersWorker.perform_async canvas.get "/api/v1/users/#{canvas_user['id']}/profile"
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
    rescue
      # FIXME: Need to update this user here...
      #puts $!.inspect, $@
    else
      CanvasUsers.update user
    end
  end
end
