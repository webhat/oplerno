require 'spec_helper'


describe Admin::CoursesController do
  render_views
  login_admin

  before(:each) do
    @user = FactoryGirl.create(:user)
  end


  describe 'Get courses' do

    let(:valid_attributes) { {name: 'Test Name Courses', teacher: @user.id} }

    before(:each) do
      @course = Course.create! valid_attributes
      @course.create_rank
    end

    after(:each) do
      @course.destroy
    end

    it "gets the index" do
      get :index
      assigns(:courses).should_not eq nil
    end

    it "shows the record" do
      get :show, :id => @course.id
      assigns(:course).should eq(@course)
    end
  end
end
