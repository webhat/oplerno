class UserObserver < ActiveRecord::Observer
	observe :user

	def after_create(user)
		user.logger.info('New user added!')
		Notification.new_user(user).deliver

		if user.is_teacher?
			Notification.faculty_invite(user).deliver
		end
	end
end
