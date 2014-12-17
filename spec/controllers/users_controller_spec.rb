require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers

  let(:valid_attributes) { {email: 'example_user@oplerno.com', password: '1234567890'} }

  let(:valid_session) { {} }

  def current_user_id
    session['warden.user.user.key'][0][0]
  end

  def current_user
    User.find(current_user_id)
  end

  context 'GET edit' do
    context 'while signed in' do
      login_user

      it 'should show first_name' do
        user = current_user
        user.first_name = 'Test Name'
        user.save

        get :edit, {id: current_user_id}
        assigns(:user).encrypted_first_name.should eq current_user.encrypted_first_name
      end
      it 'should show email' do
        get :edit, {id: current_user_id}
        assigns(:user).email.should eq current_user.email
      end
    end
    context 'while signed out' do
      before do
        @user = FactoryGirl.create(:user)
      end
      it 'should show email' do
        get :edit, {id: @user.id}
        assigns(:user).email.should eq @user.email
      end
    end
  end

  context 'PUT update' do
    context 'while signed in' do
      login_user
      it 'should update first_name' do
        user = current_user
        user.first_name = 'Test Name'
        user.save

        put :update, {id: user.to_param, user: {first_name: 'Other Name'}}
        user.reload
        assigns(:user).encrypted_first_name.should eq user.encrypted_first_name
      end
      it 'should update email' do
        user = current_user

        put :update, {id: user.to_param, user: {email: 'test_user_controller@oplerno.com'}}
        user.reload
        assigns(:user).email.should eq user.email
      end
    end
    context 'while signed out'
  end

  context 'GET show' do
    context 'while signed in' do
      login_user

      it 'should show first_name' do
        user = current_user
        user.first_name = 'Test Name'
        user.save

        get :show, {id: current_user_id}
        assigns(:user).encrypted_first_name.should eq current_user.encrypted_first_name
      end
      it 'should show email' do
        get :show, {id: current_user_id}
        assigns(:user).email.should eq current_user.email
      end
    end
    context 'while signed out'
  end
end

