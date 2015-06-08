require 'spec_helper'

describe MentorsController do
  let(:mentor) { create :mentor }
  context ':show' do
    before do
    end
    it 'should get a page' do
      get :show, { id: mentor.id }
      expect(response).to be_success
    end
  end
end
