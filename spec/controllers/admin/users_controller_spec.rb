require 'spec_helper'


describe Admin::UsersController do
  render_views
  login_admin

  describe 'Get users' do
    let(:valid_attributes) { {email: 'example_teacher@example.com', password: '1234567890', password_confirmation: '1234567890'} }

    before(:each) do
      @user = User.create! valid_attributes
    end

    after(:each) do
      @user.destroy
    end

    it "gets the index" do
      skip
      get :index
      expect(assigns(:users)).to_not eq nil
    end

    it "shows the record" do
      get :show, :id => @user.id
      expect(assigns(:user)).to eq(@user)
    end
  end
end
