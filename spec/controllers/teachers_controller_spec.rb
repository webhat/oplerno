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


  describe 'PUT edit' do
    before do
      @user = FactoryGirl.create(:teacher)
    end
    context 'logged in as user' do
      login_user

      def current_user_id
        session['warden.user.user.key'][0][0]
      end

      def current_user
        User.find(current_user_id)
      end

      it 'updates the requested teacher' do
        User.any_instance.should_receive(:update_attributes).with({'username' => 'test.user'})
        put :update, {id: current_user_id, :teacher => {:username => 'test.user'}}
      end

      it "fails to assign the requested teacher as @teacher" do
        teacher = Teacher.create! valid_attributes
        put :update, {:id => teacher.to_param, :teacher => {:username => 'test.user'}}
        expect(response).to_not be_success
        assigns(:teacher).should eq(teacher)
        assigns(:teacher).username.should_not eq('test.user')
      end

      it "assigns the requested teacher as @teacher" do
        teacher = Teacher.find(current_user_id)
        put :update, {:id => teacher.to_param, :teacher => {:username => 'test.user'}}
        expect(response).to_not be_success
        assigns(:teacher).username.should eq('test.user')
      end

      it "redirects to the teacher if bad update" do
        teacher = Teacher.create! valid_attributes
        put :update, {:id => teacher.to_param, :teacher => valid_attributes}
        expect(response).to_not be_success
        flash[:alert].should eq (I18n.t 'users.fail.user_record')
        response.should redirect_to(teacher)
      end

      it "redirects to the teacher" do
        teacher = Teacher.find(current_user_id)
        put :update, {:id => teacher.to_param, :teacher => valid_attributes}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'teachers.success.update')
        response.should redirect_to(teacher)
      end

      it 'edits the first_name field' do
        teacher = Teacher.find(current_user_id)
        put :update, {:id => teacher.to_param, :teacher => {first_name: 'Daniel'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'teachers.success.update')
        response.should redirect_to(teacher)
      end

      it 'edits the last_name field' do
        teacher = Teacher.find(current_user_id)
        put :update, {:id => teacher.to_param, :teacher => {last_name: 'Croem'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'teachers.success.update')
        response.should redirect_to(teacher)
      end

      it 'edits the first_name field' do
        teacher = Teacher.find(current_user_id)
        put :update, {:id => teacher.to_param, :teacher => {first_name: 'Daniël'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'teachers.success.update')
        response.should redirect_to(teacher)
      end

      it 'edits the last_name field' do
        teacher = Teacher.find(current_user_id)
        put :update, {:id => teacher.to_param, :teacher => {last_name: 'Croëm'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'teachers.success.update')
        response.should redirect_to(teacher)
      end

      it 'edits the password field' do
        teacher = Teacher.find(current_user_id)
        put :update, {:id => teacher.to_param, :teacher => {password: 'abcdefghij', password_confirmation: 'abcdefghij'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'teachers.success.update')
        response.should redirect_to(teacher)
      end
    end

    context 'not logged in as user' do
      it 'responds successfully with an HTTP 302 status code' do
        put :edit, {id: @user.id}
        expect(response).to_not be_success
        expect(response.status).to eq(302)
      end
      it 'responds successfully redirects to new user session' do
        put :edit, {id: @user.id}
        response.should redirect_to(new_user_session_url)
      end
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

      it 'renders the edit template' do
        get :edit, {id: current_user_id}
        expect(response).to render_template('edit')
      end
      it "responds successfully with an HTTP 200 status code" do
        get :edit, {id: current_user_id}
        expect(response).to be_success
        expect(response.status).to eq(200)
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
