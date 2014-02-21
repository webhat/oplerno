require 'spec_helper'

describe "PasswordResets" do
  describe "GET /users/password/new" do
    it "works!" do
      visit '/users/password/new'

      page.status_code.should == 200
    end

    it "emails user when requesting password reset" do
      user = FactoryGirl.build(:teacher)
      visit '/users/sign_in'
      click_link "password"
      fill_in "Email", :with => user.email
      click_button I18n.t('devise.passwords.send')
    end
  end
end
