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
end
