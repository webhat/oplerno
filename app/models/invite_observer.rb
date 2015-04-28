class InviteObserver < ActiveRecord::Observer
  observe :invite

  def after_create(invite)
    InviteMailer.thanks(invite).deliver
  end
end
