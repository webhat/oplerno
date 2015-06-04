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
    let(:team) { create :team }
    it 'should get a page' do
      post :update, { id: team.id, resource: {} }
      expect(response).to be_redirect
      expect(response).to redirect_to team
    end
    it 'should update description' do
      post :update, { id: team.id, resource: {description: 'It works'} }
      team.reload
      expect(team.description).to eq 'It works'
    end
  end
end
