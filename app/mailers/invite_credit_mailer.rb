class InviteCreditMailer < ActionMailer::Base
  default from: 'from@example.com'

  def by_user invite_credit
    to = invite_credit.user

    email = get_recipient_email(to)

    subject = credit_mail_user invite_credit, email

    mail(subject: subject, to: email)

    self
  end

  private

  def credit_mail_user invite_credit, email
    if invite_credit.user.id == invite_credit.by.id 
      I18n.t('invites.invite_credit.accepted', user: email)
    else
      I18n.t('invites.invite_credit.notification', user: email)
    end
  end

  def get_recipient_email to
    unless to.unconfirmed_email.nil?
      to.unconfirmed_email
    else
      to.email
    end
  end
end
