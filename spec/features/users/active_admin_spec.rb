require 'spec_helper'

describe 'Active Admin' do

  before(:all) do
    I18n.locale = :en
  end

  it "rejects a reqular user" do
    @user = FactoryGirl.create(:user)

    visit '/users/sign_out'
    visit '/users/sign_in'
    fill_in I18n.t('devise.sessions.new.email'), with: @user.email
    fill_in I18n.t('devise.sessions.new.password'), with: @user.password
    click_button I18n.t('devise.sessions.new.sign_in')

    visit "/admin"
    expect(page).not_to have_content "Dashboard"
    expect(page).to have_content "You need to sign in or sign up before continuing."
  end

  it "accepts an admin user" do
    @user = FactoryGirl.create(:admin_user)

    visit '/admin/logout'
    visit '/admin/login'
    fill_in I18n.t('devise.sessions.new.email'), with: @user.email
    fill_in I18n.t('devise.sessions.new.password'), with: @user.password
    click_button 'Login' #I18n.t('devise.sessions.new.sign_in')

    visit "/admin"
    expect(page).to have_content "Dashboard"
    expect(page).to_not have_content "You need to sign in or sign up before continuing."
  end

end
