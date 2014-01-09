#encoding: UTF-8
require 'spec_helper'

describe StudentsController do

  let(:valid_attributes) { {username: 'old.user.name', email: 'example_student@oplerno.com', password: '1234567890', password_confirmation: '1234567890'} }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index, {}, valid_session
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      get :index, {}, valid_session
      expect(response).to render_template('index')
    end
  end

  describe "GET show" do
    it 'assigns the requested user as @student' do
      student = Student.create! valid_attributes
      get :show, {:id => student.to_param}, valid_session
      assigns(:student).should eq(student)
    end
  end

  describe 'PUT edit' do
    before do
      @user = FactoryGirl.create(:student)
    end
    context 'logged in as user' do
      login_user

      def current_user_id
        session['warden.user.user.key'][0][0]
      end

      def current_user
        User.find(current_user_id)
      end

      it 'updates the requested student' do
        User.any_instance.should_receive(:update_attributes).with({'username' => 'test.user'})
        put :update, {id: current_user_id, :student => {:username => 'test.user'}}
      end

      it "fails to assign the requested student as @student" do
        student = Student.create! valid_attributes
        put :update, {:id => student.to_param, :student => {:username => 'test.user'}}
        expect(response).to_not be_success
        assigns(:student).should eq(student)
        assigns(:student).username.should_not eq('test.user')
      end

      it "assigns the requested student as @student" do
        student = Student.find(current_user_id)
        put :update, {:id => student.to_param, :student => {:username => 'test.user'}}
        expect(response).to_not be_success
        assigns(:student).username.should eq('test.user')
      end

      it "redirects to the student if bad update" do
        student = Student.create! valid_attributes
        put :update, {:id => student.to_param, :student => valid_attributes}
        expect(response).to_not be_success
        flash[:alert].should eq (I18n.t 'users.fail.user_record')
        response.should redirect_to(student)
      end

      it "redirects to the student" do
        student = Student.find(current_user_id)
        put :update, {:id => student.to_param, :student => valid_attributes}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'students.success.update')
        response.should redirect_to(student)
      end

      it 'edits the first_name field' do
        student = Student.find(current_user_id)
        put :update, {:id => student.to_param, :student => {first_name: 'Daniel'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'students.success.update')
        response.should redirect_to(student)
      end

      it 'edits the last_name field' do
        student = Student.find(current_user_id)
        put :update, {:id => student.to_param, :student => {last_name: 'Croem'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'students.success.update')
        response.should redirect_to(student)
      end

      it 'edits the first_name field' do
        student = Student.find(current_user_id)
        put :update, {:id => student.to_param, :student => {first_name: 'Daniël'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'students.success.update')
        response.should redirect_to(student)
      end

      it 'edits the last_name field' do
        student = Student.find(current_user_id)
        put :update, {:id => student.to_param, :student => {last_name: 'Croëm'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'students.success.update')
        response.should redirect_to(student)
      end

      it 'edits the password field' do
        student = Student.find(current_user_id)
        put :update, {:id => student.to_param, :student => {password: 'abcdefghij', password_confirmation: 'abcdefghij'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'students.success.update')
        response.should redirect_to(student)
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
      @user = FactoryGirl.create(:student)
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
