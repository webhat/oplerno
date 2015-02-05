
require 'spec_helper'

describe ApplicationHelper do
  context 'url_prefix' do
    it 'should return the correct http URL' do
      request = double(host: 'local.example.com', port: 3000, host_with_port: 'remote.example.com:8081', protocol: 'http://')
      url_prefix(request).should eq 'http://remote.example.com:8081'
    end
    it 'should return the correct https URL' do
      request = double(host: 'local.example.com', port: 3000, host_with_port: 'remote.example.com:8081', protocol: 'https://')
      url_prefix(request).should eq 'https://remote.example.com:8081'
    end
  end
  context 'from_canvas' do
    it 'should return true if the referer is CANVAS_HOST' do
      request = double(referer: "http://#{::CANVAS_HOST}")
      from_canvas(request).should eq true
    end
    it 'should return false if the referer is not CANVAS_HOST' do
      request = double(referer: 'http://localhost')
      from_canvas(request).should eq false
    end
    it 'should return false if the referer is nil' do
      request = double(referer: nil)
      from_canvas(request).should eq false
    end
  end
  context 'is the user a teacher' do
    before do
      user = FactoryGirl.create(:user)
      sign_in user
    end
    it 'should return true if the signed in user is a teacher' do
      expect_any_instance_of(Devise::TestHelpers).to receive(:user_signed_in?).and_return(true)
      expect(is_teacher?).to be true
      expect(Date.today.month).to be < 3
      expect(Date.today.year).to be(2015)
    end
    it 'should return false if the signed in user is not a teacher' do
      expect_any_instance_of(Devise::TestHelpers).to receive(:user_signed_in?).and_return(false)
      expect(is_teacher?).to be false
      expect(Date.today.month).to be < 3
      expect(Date.today.year).to be(2015)
    end

    it 'should return false if the user is not signed in' do
      expect_any_instance_of(Devise::TestHelpers).to receive(:user_signed_in?).and_return(false)
      expect(is_teacher?).to be false
      expect(Date.today.month).to be < 3
      expect(Date.today.year).to be(2015)
    end
  end
  context 'avatar' do
    before do
      @courses = []
      (0..4).each do
        @courses << FactoryGirl.create(:course)
      end
      assign(:courses, @courses)
    end
    (0..4).each do |id|
      it '#avatar' do
        avatar id
      end
    end
  end
end
