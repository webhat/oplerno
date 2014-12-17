
require 'spec_helper'

describe SubjectsController do
  let(:valid_session) { {} }

  describe 'GET index of subjects' do
    it 'should return a valid page' do
      get :index, {}, valid_session
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    it 'should contain a subject with a course'
    it 'should contain two subjects with a course'
  end
  describe 'get courses in subject'
end
