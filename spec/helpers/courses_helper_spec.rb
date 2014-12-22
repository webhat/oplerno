require 'spec_helper'

describe CoursesHelper do
  context '#prefix' do
    it '@courses set return "courses"' do
      @courses = []

      expect(prefix).to eq 'courses'
    end
    it '@courses not set return "course"' do
      expect(prefix).to eq 'course'
    end
  end
  context '#course_cache_id' do
    it 'should generate global id' do
      expect_any_instance_of(CoursesHelper).to receive(:cache_id).and_return('YYY')
      expect_any_instance_of(Devise::TestHelpers).to receive(:current_user).and_return(nil)

      course = FactoryGirl.create(:course)
      expect(course_cache_id course).to eq "course_YYY_#{course.id}"
    end
    it 'should generate user specific id' do
      user = FactoryGirl.create(:user)
      expect_any_instance_of(CoursesHelper).to receive(:cache_id).and_return('YYY')
      allow_any_instance_of(Devise::TestHelpers).to receive(:current_user).and_return(user)

      course = FactoryGirl.create(:course)
      expect(course_cache_id course).to eq "course_YYY_#{course.id}_#{user.id}"
    end
  end
  context '#teachers_course' do
    it 'should be false when not signed in' do
      expect_any_instance_of(Devise::TestHelpers).to receive(:user_signed_in?).and_return(false)
      @course = FactoryGirl.build(:course, teacher: nil)

      expect(teachers_course?).to eq false
    end
    it 'should be false when the assigned teacher is not the signed in user' do
      user = FactoryGirl.create(:user)
      expect_any_instance_of(Devise::TestHelpers).to receive(:user_signed_in?).and_return(true)
      expect_any_instance_of(Devise::TestHelpers).to receive(:current_user).and_return(user)
      @course = FactoryGirl.create(:course)
      @course.teacher = FactoryGirl.create(:user).id.to_s

      expect(teachers_course?).to eq false
    end
    it 'should be true when the assigned teacher is the signed in user' do
      user = FactoryGirl.create(:user)
      expect_any_instance_of(Devise::TestHelpers).to receive(:user_signed_in?).and_return(true)
      expect_any_instance_of(Devise::TestHelpers).to receive(:current_user).and_return(user)
      @course = FactoryGirl.create(:course)
      @course.teacher = user.id.to_s

      expect(teachers_course?).to eq true
    end
  end
end
