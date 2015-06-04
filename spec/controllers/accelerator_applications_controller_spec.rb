require 'spec_helper'

describe AcceleratorApplicationsController do

  context ':create' do
    it 'create :team' do
      team = FactoryGirl.create(:team)
      post :create, accelerator_application: { team: team.id,
                                               description: 'blah',
                                               email: 'email@email.org' }
      expect(response).to be_redirect
    end
    it 'create :mentor' do
      mentor = FactoryGirl.create(:mentor)
      post :create, accelerator_application: { mentor: mentor.id,
                                               description: 'blah',
                                               email: 'email@email.org' }
      expect(response).to be_redirect
    end
  end
end
