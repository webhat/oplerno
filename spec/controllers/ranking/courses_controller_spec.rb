require 'spec_helper'

describe Ranking::CoursesController do
  before do
    @course = FactoryGirl.create(:course)
    @course_ranking = @course.create_rank
  end

  describe 'GET :show' do
    context 'logged in' do
      login_user

      it 'returns http success json' do
        get :show, {id: Course.first.id, format: 'json'}
        expect(response).to be_success
      end
      it 'returns http not success' do
        get :show, {id: Course.first.id}
        expect(response).to_not be_success
      end
    end
    context 'not logged in' do
      it 'redirect' do
        get :show, {id: Course.first.id}
        expect(response).to redirect_to new_user_session_url
      end
      it 'redirect json' do
        get :show, {id: Course.first.id, format: 'json'}
        expect(response.status).to eq 401
      end
    end
  end
end
