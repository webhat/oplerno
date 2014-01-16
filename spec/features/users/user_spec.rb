require 'spec_helper'

describe 'User Login' do

  before(:all) do
    I18n.locale = :en
  end

  it "accepts a reqular user" do
    @user = FactoryGirl.build(:user, password: 'testtest')
    @user.confirm!

    visit '/users/sign_out'
    visit '/users/sign_in'
    fill_in I18n.t('devise.sessions.new.email'), with: @user.email
    fill_in I18n.t('devise.sessions.new.password'), with: 'testtest'
    click_button I18n.t('devise.sessions.new.sign_in')

    visit "/courses"
    expect(page).to have_content I18n.t('devise.sessions.new.sign_out')
  end

  it "rejects an admin user" do
    @user = FactoryGirl.create(:admin_user)

    visit '/admin/logout'
    visit '/admin/login'
    fill_in I18n.t('devise.sessions.new.email'), with: @user.email
    fill_in I18n.t('devise.sessions.new.password'), with: @user.password
    click_button 'Login' #

    visit "/courses"
    expect(page).to have_content I18n.t('devise.sessions.new.sign_in')
  end
end
