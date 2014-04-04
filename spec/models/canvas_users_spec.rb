#encoding: UTF-8
require 'spec_helper'

describe CanvasUsers do
  let(:valid_canvas_user) { {"id" => 34, "name" => "Daniël W. Crompton", "short_name" => "Daniël W. Crompton", "sortable_name" => "Crompton, Daniël", "login_id" => "crompton@oplerno.com", "avatar_url" => "https://secure.gravatar.com/avatar/fb960cf51cfb4573c04dd043234ffe67?s=50&d=https%3A%2F%2Foplerno.test.instructure.com%2Fimages%2Fmessages%2Favatar-50.png", "title" => nil, "bio" => nil, "primary_email" => "crompton@oplerno.com", "time_zone" => "Europe/Amsterdam", "calendar" => {"ics" => "https://oplerno.test.instructure.com/feeds/calendars/user_YU1iCCwJuMt35BllSGdcAK4Py068EyRKEODCoBCg.ics"}} }
  let(:valid_user) { {email: valid_canvas_user['login_id'], password: '1234567890', password_confirmation: '1234567890'} }

  context 'Factory' do
    it 'has a valid factory' do
      FactoryGirl.create(:canvas_user).should be_valid
    end
    it 'is valid with a student' do
      FactoryGirl.build(:canvas_user, user: FactoryGirl.create(:student)).should be_valid
    end
  end

  vcr_options = {:record => :none}
  context 'Interact with Canvas', vcr: vcr_options do
    it 'gets an update for a non existing user' do
      CanvasUsers.update valid_canvas_user
      expect(CanvasUsers.find_by_username (valid_canvas_user['login_id'])).to be_a(CanvasUsers)
    end
    it 'gets an update for a existing user' do
      old_user = User.find_by_email(valid_user['email'])
      old_user.delete unless old_user.nil?

      user = User.create! valid_user
      CanvasUsers.update valid_canvas_user
      canvas_user = CanvasUsers.find_by_username (valid_canvas_user['login_id'])

      expect(user).to eq canvas_user.user
    end
    it 'gets an update for all users' do
      pending 'Errors out on occasion'
      CanvasUsers.update_all
    end
  end

  context 'Sync With Canvas' do
    it 'should create CanvasUser' do
      CanvasUsers.should_receive(:after_commit).at_least(:once)
      CanvasUsers.stub(:canvas).and_return(nil)
      user = User.create! ({email: 'reggie@example.com', password: 'testtest1', password_confirmation: 'testtest1', confirmed_at: Time.now})
      user.run_callbacks(:commit)
    end
    it 'should call sync with Canvas' do
			pending 'bug'
      CanvasUsers.any_instance.should_receive(:canvas_sync).at_least(:once)
      user = User.create! ({email: 'reggie@example.com', password: 'testtest1', password_confirmation: 'testtest1', confirmed_at: Time.now})
      CanvasUsers.after_commit(user)
    end
    it 'should fail if user exists locally'
    it 'should succeed if user not exists remotely' do
      mock = double(Canvas::API)
      mock.stub(:post).and_return(valid_canvas_user)
      CanvasUsers.stub(:canvas).and_return(mock)
      canvas_user = CanvasUsers.create!(username: 'reggie@example.com')
    end
    it 'should fail if user exists remotely' do
      mock = double(Canvas::API)
      mock.stub(:post).and_raise(Canvas::ApiError)
      CanvasUsers.stub(:canvas).and_return(mock)
      canvas_user = CanvasUsers.create!(username: 'reggie@example.com')
    end
  end
end
