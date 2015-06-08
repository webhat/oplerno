class InviteCreditObserver < ActiveRecord::Observer
  observe :invite_credit

  def after_create(ic)
    InviteCreditMailer.by_user(ic).deliver
  end
end
