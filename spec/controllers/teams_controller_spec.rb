require 'spec_helper'

describe TeamsController do
  context ':show' do
    let(:team) { create :team }
    it 'should get a page' do
      get :show, { id: team.id }
      expect(response).to be_success
    end
  end
  context ':update' do
    login_user
    let(:team) { create :team }
    let(:mentor) { create :mentor }
    it 'should get a page' do
      team.mentors << Mentor.find(current_user.id)
      team.save
      post :update, { id: team.id, format: 'json', resource: {description: 'test'} }
      expect(response.status).to eq 200
    end
    it 'get a 406 Not Acceptable Response' do
      team.mentors << mentor
      post :update, { id: team.id, format: 'json', resource: {} }
      expect(response.status).to eq 403
    end
    it 'get a 406 Not Acceptable Response' do
      post :update, { id: team.id, format: 'json', resource: {} }
      expect(response.status).to eq 403
    end
    it 'should update description' do
      team.mentors << Mentor.find(current_user.id)
      post :update, { id: team.id, format: 'json', resource: {description: 'It works'} }
      team.reload
      expect(team.description).to eq 'It works'
    end
  end
end
