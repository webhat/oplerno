require 'spec_helper'

describe 'Teacher' do

  before(:all) do
    I18n.locale = :en
  end

  context 'required' do
    let (:teacher) { create :teacher, password: 'testtest', email: 'test@oplerno.com' }
    let (:course) { create :course }
    it 'Login' do
      teacher.confirm!

      visit '/users/sign_out'
      visit '/users/sign_in'
      fill_in I18n.t('devise.sessions.new.email'), with: teacher.email
      fill_in I18n.t('devise.sessions.new.password'), with: 'testtest'
      click_button I18n.t('devise.sessions.new.sign_in')

      visit '/courses'
      expect(page).to have_content I18n.t('devise.sessions.new.sign_out')
    end
    it 'contact', js: true do
      course.teachers << teacher
      course.save

      visit "/courses/#{course.id}"
      expect(page).to have_content course.display_name
      click_link I18n.t('courses.contact')
    end
  end

  it 'rejects an admin user' do
    @user = FactoryGirl.create(:admin_user)

    visit '/admin/logout'
    visit '/admin/login'
    fill_in I18n.t('devise.sessions.new.email'), with: @user.email
    fill_in I18n.t('devise.sessions.new.password'), with: @user.password
    click_button I18n.t('login.button') #

    visit '/courses'
    expect(page).to have_content I18n.t('devise.sessions.new.sign_in')
  end
end
#  vim: set ts=2 sw=2 tw=0 et :
