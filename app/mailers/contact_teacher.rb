class ContactTeacher < ActionMailer::Base
	default from: 'webmaster@oplerno.com'

	def student_mail(message)
		@message = message
		mail(to: @message[:email], bcc: 'admissions@oplerno.com',
				 subject: "Student Inquiry on #{@message[:course]}",
				 template_name: 'student_mail'
				)
	end
end
