#encoding: UTF-8
require 'spec_helper'

describe TeachersController do

  let(:valid_attributes) { {email: 'example_teacher@oplerno.com', password: '1234567890', password_confirmation: '1234567890'} }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, {}, valid_session
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index, {}, valid_session
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      teacher = Teacher.create! valid_attributes
      get :show, {:id => teacher.to_param}, valid_session
      assigns(:teacher).should eq(teacher)
    end
  end

  describe 'GET edit' do
    before do
      @user = FactoryGirl.create(:teacher)
    end
    context 'logged in as user' do
      login_user

      def current_user_id
        session['warden.user.user.key'][0][0]
      end

      it 'renders the edit template for current' do
        get :edit, {id: @user.id}
        expect(response).to_not be_success
        expect(response.status).to eq(302)
      end
    end

    context 'not logged in as user' do
      it 'responds successfully with an HTTP 302 status code' do
        get :edit, {id: @user.id}
        expect(response).to_not be_success
        expect(response.status).to eq(302)
      end
      it 'responds successfully redirects to new user session' do
        get :edit, {id: @user.id}
        response.should redirect_to(new_user_session_url)
      end
    end
  end
end
