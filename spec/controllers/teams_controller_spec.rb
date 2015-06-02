require 'spec_helper'

describe TeamsController do
  context ':show' do
    let(:team) { create :team }
    it 'should get a page' do
      get :show, { id: team.id }
      expect(response).to be_success
    end
  end
end
