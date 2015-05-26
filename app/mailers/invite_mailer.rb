class InviteMailer < ActionMailer::Base
  default from: 'webmaster@oplerno.com'

  layout 'email'

  def thanks invite
    @invite = invite
    to = invite.user

    subject = I18n.t('invites.invite.accepted', user: to.email)

    mail(subject: subject, to: to.email)

    self
  end
end
