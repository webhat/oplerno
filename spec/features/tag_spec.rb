require 'spec_helper'

describe TagsController do
  context 'when logged out' do
    let(:mentor) { create :mentor, description: "" }
    it 'visit mentor page' do
      mentor.tags << Tag.create!( name: 'blaat' )
      #TagsController when logged out visit mentor page
      visit "/mentors/#{mentor.id}"
      expect(page.find('#tags')).to have_content 'blaat'
    end
  end
  context 'when logged in' do
    let(:mentor) { create :mentor, description: "", password: 'testtest' }
    it 'visit mentor page' do
      mentor.tags << Tag.create!( name: 'blaat' )

      visit '/users/sign_out'
      visit '/users/sign_in'
      fill_in I18n.t('devise.sessions.new.email'), with: mentor.email
      fill_in I18n.t('devise.sessions.new.password'), with: 'testtest'
      click_button I18n.t('devise.sessions.new.sign_in')
      #TagsController when logged out visit mentor page
 
      visit "/mentors/#{mentor.id}"
      expect(page.find('#tags')).to have_content 'blaat'
    end
    it 'visit mentor page' do
      mentor.tags << Tag.create!( name: 'blaat' )

      visit '/users/sign_out'
      visit '/users/sign_in'
      fill_in I18n.t('devise.sessions.new.email'), with: mentor.email
      fill_in I18n.t('devise.sessions.new.password'), with: 'testtest'
      click_button I18n.t('devise.sessions.new.sign_in')
 
      visit "/mentors/#{mentor.id}"
      expect(page.find('#tags')).to have_content 'blaat'
    end
    it 'visit mentor page add tag', js: true do
      mentor.confirm
      mentor.tags << Tag.create!( name: 'blaat' )

      visit '/users/sign_out'
      visit '/users/sign_in'
      fill_in I18n.t('devise.sessions.new.email'), with: mentor.email
      fill_in I18n.t('devise.sessions.new.password'), with: 'testtest'
      click_button I18n.t('devise.sessions.new.sign_in')
 
      visit "/mentors/#{mentor.id}"
      find('.new-tag-button').click
      fill_in('new-tag-input', with: 'poekoe')
      find('input[name="new-tag-input"]').native.send_key(:Enter)

      expect(page.find('#tags')).to have_content 'poekoe'

      visit "/mentors/#{mentor.id}"

      #save_and_open_screenshot

      expect(page.find('#tags')).to have_content 'poekoe'
    end
  end
end

