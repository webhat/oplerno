# Mail notifications
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
    @user = user

    unless user.privateemail.nil?
      subject = t('teachers.mail.welcome')

      mail(subject: subject, to: user.privateemail)
    end

    self
  end

  def order_transaction user
    return if user.nil?
    @user = user

    subject = t('users.mail.order_transaction')

    mail(subject: subject, user: user)

    self
  end

  def order user
    return if user.nil?
    @user = user

    subject = t('users.mail.order')

    mail(subject: subject, user: user)

    self
  end
end
