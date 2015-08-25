require 'spec_helper'

describe VersionsController do
  describe "POST revert", :versioning => true  do
    describe "with more than one version" do
      it "reverts to the last version" do
        request.env["HTTP_REFERER"] = 'http://127.0.0.1/'

        user = FactoryGirl.create(:user)
        email = user.email
        user.update_attributes!(:email => 'x@example.com')
        user.update_attributes!(:email => 'y@example.com')
        expect(user).to be_versioned
        post :revert, {id: user.versions.first.id }
        expect(user.reload.email).to eq email
      end
    end
  end
end
