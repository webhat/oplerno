#encoding: UTF-8
require 'spec_helper'

describe CoursesController do
  include Devise::TestHelpers

  let(:valid_attributes) { {name: 'Wine course', teacher: current_user.id, subject: ""} }

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

  describe 'POST create' do
		login_user
		it 'can create a course with an empty subject' do
			post :create, valid_attributes
			expect(response).to be_success
			assigns(:course).should be_a(Course)
		end
	end

  describe 'PUT edit' do
    before do
      @course = FactoryGirl.create(:course)
      @course.teacher = 1
      @course.save
    end

    context 'logged in as user' do
      login_user

      before do
        @course.teacher = current_user.id
        @course.save
      end

      it 'updates the requested course' do
        Course.any_instance.should_receive(:update_attributes).with({'name' => 'test.user'})
        put :update, {id: @course.id, :course => {:name => 'test.user'}}
      end

      it "assigns the requested course as @course" do
        put :update, {:id => @course.to_param, :course => {:name => 'test.user'}}
        expect(response).to_not be_success
        assigns(:course).should eq(@course)
        assigns(:course).name.should eq('test.user')
      end

      it "redirects to the course if bad update" do
        user = FactoryGirl.create(:user)
        user.confirm!
        sign_in user
        put :update, {:id => @course.to_param, :course => valid_attributes}
        expect(response).to_not be_success
        flash[:alert].should eq (I18n.t 'courses.fail.own_course')
        response.should redirect_to(@course)
      end

      it "redirects to the course" do
        put :update, {:id => @course.to_param, :course => valid_attributes}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'courses.success.update')
        response.should redirect_to(@course)
      end

      it 'edits the name field' do
        put :update, {:id => @course.to_param, :course => {name: 'Chinese Language'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'courses.success.update')
        response.should redirect_to(@course)
      end

      it 'edits the name field' do
        put :update, {:id => @course.to_param, :course => {name: '中国语文'}}
        expect(response).to_not be_success
        flash[:notice].should eq (I18n.t 'courses.success.update')
        response.should redirect_to(@course)
      end

      it 'responds successfully with an HTTP 302 status code' do
        put :update, {id: @course.id}
        expect(response).to_not be_success
        expect(response.status).to eq(302)
      end

      it 'responds successfully redirects to new user session' do
        put :update, {id: @course.id}
        response.should redirect_to(course_url)
      end
    end

    context 'not logged in as user' do
      it 'responds successfully with an HTTP 302 status code' do
        put :update, {id: @course.id}
        expect(response).to_not be_success
        expect(response.status).to eq(302)
      end

      it 'responds successfully redirects to new user session' do
        put :update, {id: @course.id}
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe 'GET edit' do
    before do
      @course = FactoryGirl.create(:course)
      @course.teacher = 1
      @course.save
    end

    context 'logged in as user' do
      login_user

      before do
        @course.teacher = current_user.id
        @course.save
      end

      it 'renders the edit template' do
        get :edit, {id: @course.id}
        expect(response).to render_template('edit')
      end

      it "responds successfully with an HTTP 200 status code" do
        get :edit, {id: @course.id}
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    context 'not logged in as user' do
      it 'responds successfully with an HTTP 302 status code' do
        get :edit, {id: @course.id}
        expect(response).to_not be_success
        expect(response.status).to eq(302)
      end

      it 'responds successfully redirects to new user session' do
        get :edit, {id: @course.id}
        response.should redirect_to(new_user_session_url)
      end
    end
  end
end

