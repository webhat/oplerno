require 'spec_helper'

describe "PasswordResets" do
  describe "GET /users/password/new" do
    it "works! (now write some real specs)" do
      get '/users/password/new'

      response.status.should be(200)
    end

    it "emails user when requesting password reset" do
      user = FactoryGirl.build(:teacher)
      visit '/users/sign_in'
      click_link "password"
      fill_in "Email", :with => user.email
      click_button 'Send me reset password instructions'
      #click_button "Reset Password"
    end
  end
end
