#encoding: UTF-8
require 'spec_helper'

describe CoursesController do
  include Devise::TestHelpers

  let(:valid_attributes) { {name: 'Wine course', subject: ""} }

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

  describe 'PUT edit' do
    let (:course) { create :course }
    context 'logged in as user' do
      login_user

      before do
        course.teachers << Teacher.find( current_user.id )
        course.save
      end

      it 'updates the requested course' do
        Course.any_instance.should_receive(:update_attributes).with({'name' => 'test.user'})
        put :update, {id: course.id, :course => {:name => 'test.user'}}
      end

      it "assigns the requested course as @course" do
        put :update, {:id => course.to_param, :course => {:name => 'test.user'}}
        expect(response).to_not be_success
        expect( assigns(:course) ).to eq(course)
        expect( assigns(:course).name ).to eq('test.user')
      end

      it "redirects to the course if bad update" do
        user = FactoryGirl.build(:user)
        user.confirm!
        user.skip_confirmation_notification!
        user.save
        sign_in user

        put :update, {:id => course.to_param, :course => valid_attributes}
        expect(flash[:alert]).to eq (I18n.t 'courses.fail.own_course')
        expect(response).to redirect_to(course)
      end

      it "redirects to the course" do
        put :update, {:id => course.to_param, :course => valid_attributes}
        expect(flash[:notice]).to eq (I18n.t 'courses.success.update') +" <span class='pull-right'></span>"
        expect(response).to redirect_to(course)
      end

      it 'edits the name field' do
        put :update, {:id => course.to_param, :course => {name: 'Chinese Language'}}
        expect(flash[:notice]).to eq (I18n.t 'courses.success.update') +" <span class='pull-right'></span>"
        expect(response).to redirect_to(course)
      end

      it 'edits the name field' do
        put :update, {:id => course.to_param, :course => {name: '中国语文'}}
        expect(flash[:notice]).to eq (I18n.t 'courses.success.update') +" <span class='pull-right'></span>"
        expect(response).to redirect_to(course)
      end

      it 'responds successfully with an HTTP 302 status code' do
        put :update, {id: course.id}
        expect(response.status).to eq(302)
      end

      it 'responds successfully redirects to new user session' do
        put :update, {id: course.id}
        expect(response).to redirect_to(course_path(course.slug))
      end
    end

    context 'not logged in as user' do
      it 'responds successfully with an HTTP 302 status code' do
        put :update, {id: course.id}
        expect(response.status).to eq(302)
      end

      it 'responds successfully redirects to new user session' do
        put :update, {id: course.id}
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'GET edit' do
    let (:course) { create :course }
    context 'logged in as user' do
      login_user

      before do
        course.teachers << Teacher.find( current_user.id )
        course.save
      end

      it 'renders the edit template' do
        get :edit, {id: course.id}
        expect(response).to render_template('edit')
      end

      it "responds successfully with an HTTP 200 status code" do
        get :edit, {id: course.id}
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    context 'not logged in as user' do
      it 'responds successfully with an HTTP 302 status code' do
        get :edit, {id: course.id}
        expect(response.status).to eq(302)
      end

      it 'responds successfully redirects to new user session' do
        get :edit, {id: course.id}
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'GET image_picker' do
    let (:course) { create :course }
    describe 'while logged in' do
      login_user
      before(:each) do
        course.teachers << Teacher.find( current_user.id )
        course.avatar = File.open('app/assets/images/logo.png')
        course.save

        @course_alt = Course.create! name: 'Course Name'
      end
      it 'should change the image' do
        post :image_picker, {"image-picker" => @course_alt.id, id: course.id}
      end
    end
  end
end

