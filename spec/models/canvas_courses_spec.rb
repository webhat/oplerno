#encoding: UTF-8
require 'spec_helper'

describe CanvasCourses do

  let(:valid_canvas_course) { {
      "account_id" => 1,
      "course_code" => "FAC-101",
      "default_view" => "modules",
      "id" => 50,
      "name" => "Faculty Orientation",
      "start_at" => "2013-07-08T19=>34=>00Z",
      "end_at" => nil,
      "public_syllabus" => false,
      "storage_quota_mb" => 1500,
      "apply_assignment_group_weights" => true,
      "calendar" => {
          "ics" => ""
      },
      "sis_course_id" => nil,
      "hide_final_grades" => false,
      "workflow_state" => "available"
  } }
  let(:valid_canvas_user) { {
      "id" => 34,
      "name" => "Daniël W. Crompton",
      "short_name" => "Daniël W. Crompton",
      "sortable_name" => "Crompton, Daniël",
      "login_id" => "crompton@oplerno.com",
      "avatar_url" => "https://secure.gravatar.com/avatar/fb960cf51cfb4573c04dd043234ffe67?s=50&d=https%3A%2F%2Foplerno.test.instructure.com%2Fimages%2Fmessages%2Favatar-50.png",
      "title" => nil,
      "bio" => nil,
      "primary_email" => "crompton@oplerno.com",
      "time_zone" => "Europe/Amsterdam",
      "calendar" => {"ics" => "https://oplerno.test.instructure.com/feeds/calendars/user_YU1iCCwJuMt35BllSGdcAK4Py068EyRKEODCoBCg.ics"}
  } }
  let(:valid_user) { {email: 'test@oplerno.com', password: '1234567890', password_confirmation: '1234567890'} }

  context 'Factory' do
    it 'has a valid factory' do
      FactoryGirl.create(:canvas_course).should be_valid
    end
    it 'is valid with a course' do
      FactoryGirl.build(:canvas_course, course: FactoryGirl.create(:course)).should be_valid
    end
  end

  vcr_options = {:record => :none}
  context 'Interact with Canvas', vcr: vcr_options do
    it 'gets an update for a non existing course' do
      CanvasCourses.update valid_canvas_course
      expect(CanvasCourses.find_by_canvas_id (valid_canvas_course['id'])).to be_a(CanvasCourses)
    end
    it 'gets an update for a existing course' do
      CanvasCourses.update valid_canvas_course
      new_course = Course.create! name: 'A course'
      canvas_course = CanvasCourses.find_by_canvas_id (valid_canvas_course['id'])
      course = Course.find(canvas_course.course.id)

      expect(canvas_course.course).not_to eq new_course
      expect(canvas_course.course).to eq course
    end
    it 'gets an update for all courses' do
			pending 'you need to run a local redis and sidekiq for this to make any sense'
      CanvasCourses.update_all
    end
    it "should add the user to Canvas when linked" do
			pending 'doesn\'t work like this any more'
      Rails.logger.should_receive(:info).exactly(0).times

      canvas_course = CanvasCourses.update valid_canvas_course
      canvas_course.save

      canvas_user = CanvasUsers.update valid_canvas_user
      canvas_user.create_user! valid_user
      canvas_user.save!
      canvas_user.user.save!

      #$stdout.should_receive(:puts)
      canvas_course.add_user canvas_user.user
    end
    it 'should log an error if it fails' do
			pending 'doesn\'t work like this any more'
      mock = double(Canvas::API)
      mock.stub(:post).and_raise(Canvas::ApiError)
      CanvasUsers.stub(:canvas).and_return(mock)

      canvas_course = CanvasCourses.update valid_canvas_course
      canvas_course.save

      canvas_user = CanvasUsers.update valid_canvas_user
      canvas_user.create_user! valid_user
      canvas_user.save!
      canvas_user.user.save!

      #$stdout.should_receive(:puts)
      canvas_course.add_user canvas_user.user
    end
  end
end
