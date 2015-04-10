require 'spec_helper'

describe InvitesController do
  context ':new' do
    login_user
    it 'Invite#persisted?' do
      get :new, {}
      expect(assigns(:invite)).to be_persisted
    end
    it 'Invite#active' do
      get :new, {}
      expect(assigns(:invite).active).to be_true
    end
    it 'Invite#code' do
      get :new, {}
      expect(assigns(:invite).code).to_not be_nil
    end
    it 'Invite#user' do
      get :new, {}
      expect(assigns(:invite).user).to eq current_user
    end
  end
  context ':create' do
    login_user
    it 'Invite#persisted?' do
      post :create, {}
      expect(assigns(:invite)).to be_persisted
    end
    it 'Invite#active' do
      post :create, {}
      expect(assigns(:invite).active).to be_true
    end
    it 'Invite#code' do
      post :create, {}
      expect(assigns(:invite).code).to_not be_nil
    end
    it 'Invite#user' do
      post :create, {}
      expect(assigns(:invite).user).to eq current_user
    end
    it 'flash[:notice]#created' do
      post :create, {}
      expect(flash[:notice]).to eq I18n.t 'invites.created'
    end
    it 'duplicate Invite' do
      post :create, {}
      post :create, {}
    end
  end
  context ':edit' do
    it 'flash[:alert]#not_applied' do
      invite = FactoryGirl.build( :invite, active: true)
      invite.save
      get :edit, {invite_validate: { code: invite.code }}
      expect(flash[:alert]).to eq I18n.t 'invites.not_applied'
    end
    it 'flash[:alert]#no_invite' do
      get :edit, {}
      expect(flash[:alert]).to eq I18n.t 'invites.no_invite'
    end
  end
  context ':update' do
    it 'flash[:notice]#applied' do
      invite = FactoryGirl.build( :invite, active: true)
      invite.save
      post :update, {invite_validate: {code: invite.code, email: Faker::Internet.email}}
      expect(flash[:notice]).to eq I18n.t 'invites.applied'
    end
    it 'Invite' do
      invite = FactoryGirl.build( :invite,
        user: FactoryGirl.create(:user),
        active: true
      )
      invite.save
      post :update, {invite_validate: {code: invite.code, email: Faker::Internet.email}}
      expect(assigns(:invite).code).to eq invite.code
    end
    it 'invite applied' do
      invite = FactoryGirl.build( :invite,
        user: FactoryGirl.create(:user),
        active: true
      )
      invite.save
      post :update, {invite_validate: {code: invite.code, email: Faker::Internet.email}}
      invite_credit = InviteCredit.find_by_user_id invite.user.id
      expect(invite_credit).to_not be_nil
    end
  end
end
