require 'spec_helper'

describe MentorsController do
  let(:mentor) { create :mentor }
  context ':show' do
    it 'should get a page' do
      get :show, { id: mentor.id }
      expect(response).to be_success
    end
  end
  context ':signup' do
    let(:setting) { create :setting, key: 'mentor_signup' }
    it 'should get a page with a code' do
      get :signup, { welcome: setting.value}
      expect(response).to be_success
    end
    it 'should be redirected' do
      get :signup, {}
      expect(response).to be_redirect
    end
  end
  context ':create' do
    it 'should create a mentor' do
      post :create, { format: 'json', mentor: {display_name: "D", email: Faker::Internet.free_email, angel: {angelslug: "a"}}}
      expect(response).to be_success
    end
  end
end
