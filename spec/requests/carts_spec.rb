require 'spec_helper'

describe 'Carts' do
  describe 'GET /carts' do
    it 'Should redirect for login' do
      get carts_path
      response.status.should be(302)
    end
    it 'Should redirect for login' do
      get carts_path
      response.should redirect_to(new_user_session_url)
    end
  end
end
