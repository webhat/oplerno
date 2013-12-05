require 'spec_helper'

describe "PasswordResets" do
  describe "GET /users/password/new" do
    it "works! (now write some real specs)" do
      get '/users/password/new'

      response.status.should be(200)
    end
  end
end
