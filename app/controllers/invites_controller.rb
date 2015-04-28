class InvitesController < ApplicationController
  before_filter :set_invite, only: [:create]
  before_filter :get_invite, only: [:edit, :update]
  before_filter :authenticate_user!, only: [:new, :create]

  helper_method :invites_code

  def new
  end

  def create
    flash[:notice] = I18n.t('invites.created')
#    redirect_to current_user
  end

  def edit
    sign_out
    unless @invite.nil?
      flash[:alert] = I18n.t('invites.not_applied')
    end
  end

  def update
    unless @invite.nil?
      flash[:notice] = I18n.t('invites.applied')
    end
    user = setup_user
    InviteCredit.create! user: @invite.user, by: @invite.user
    InviteCredit.create! user: user, by: @invite.user
    redirect_to '/'
  end

  def setup_user
    user = create_user
    user.email = invites_email
    user.save
    user.send_confirmation_instructions
    return user
  end

  private

  def get_invite
    @invite = Invite.find_by_code(invites_code)
    if @invite.nil?
      flash[:alert] = I18n.t('invites.no_invite')
      redirect_to '/'
    end
  end

  def set_invite
    unless current_user.nil?
      @invite = Invite.find_by_user_id(current_user.id)
      if @invite.nil?
        @invite = Invite.create! user: current_user, active: true
      end
    end
  end

  def invites_email
    unless params.nil?
      unless params[:invite_validate].nil?
        params[:invite_validate][:email]
      end
    end
  end

  def invites_code
    unless params.nil?
      unless params[:invite_validate].nil?
        params[:invite_validate][:code]
      end
    end
  end
end
