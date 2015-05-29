require 'spec_helper'

describe TeamsController do
  context ':show' do
    before do
      Team.create!
    end
    it 'should get a page' do
      get :show, { id: 1 }
      expect(response).to eq be_success
    end
  end
end
