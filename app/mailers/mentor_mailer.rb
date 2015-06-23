class MentorMailer < ActionMailer::Base
  default from: 'webmaster@oplerno.com'

  def email_changed mentor
    @mentor = mentor
    subject = t('courses.new_teacher', display_name: mentor.display_name)
    mail(subject: subject,
         to: mentor.unconfirmed_email
        )

    self
  end
end

