class Notification < ActionMailer::Base
	@from = 'webmaster@oplerno.com'
	default from: @from, to: @from

	layout 'email'

	def new_user user
		subject = t( 'users.mail.notification', user: user.email )
		mail(subject: subject)

		self
	end

	def faculty_invite user
		subject = t('teachers.mail.welcome')

		@user = user

		unless user.privateemail.nil?
			mail(subject: subject, to: user.privateemail)
		end

		self
	end
end
