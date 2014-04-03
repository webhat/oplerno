require 'spec_helper'

describe 'User Links' do
		context 'while logged in' do

			before(:each) do
				I18n.locale = :en

				@user = FactoryGirl.build(:user, password: 'testtest', first_name: 'Test')
				@user.confirm!

				visit '/users/sign_out'
				visit '/users/sign_in'
				fill_in I18n.t('devise.sessions.new.email'), with: @user.email
				fill_in I18n.t('devise.sessions.new.password'), with: 'testtest'
				click_button I18n.t('devise.sessions.new.sign_in')
			end

			after(:each) do
				@user.destroy
			end

			it 'should be able to submit one link with description' do
				link_name = 'LinkedIn'
				link_url = 'http://www.linkedin.com/'

				visit edit_user_path(id: @user.id)
				fill_in I18n.t('users.link.name'), with: link_name
				fill_in I18n.t('users.link.url'), with: link_url

				first(:button, I18n.t('users.update')).click
				expect(page).to have_content link_name
				find_link(link_name)[:href].should eq link_url
				first(:link, link_name)[:href].should eq link_url
			end
			it 'should be able to submit one https link with description' do
				link_name = 'LinkedIn'
				link_url = 'https://www.linkedin.com/'

				visit edit_user_path(id: @user.id)
				fill_in I18n.t('users.link.name'), with: link_name
				fill_in I18n.t('users.link.url'), with: link_url

				first(:button, I18n.t('users.update')).click
				expect(page).to have_content link_name
				find_link(link_name)[:href].should eq link_url
				first(:link, link_name)[:href].should eq link_url
			end
			it 'should be able to edit one link with description' do
				link_name = 'LinkedIn'
				link_url = 'http://www.linkedin.com/'

				visit edit_user_path(id: @user.id)
				fill_in I18n.t('users.link.name'), with: link_name
				fill_in I18n.t('users.link.url'), with: link_url

				first(:button, I18n.t('users.update')).click
				expect(page).to have_content link_name
				find_link(link_name)[:href].should eq link_url
				first(:link, link_name)[:href].should eq link_url

				visit edit_user_path(id: @user.id)

				first(:field, I18n.t('users.link.name')).value.should eq link_name 
				first(:field, I18n.t('users.link.url')).value.should eq link_url 

				link_name = 'Google'
				link_url = 'http://www.google.com/'

				fill_in 'user[links][0][name]', with: link_name
				fill_in 'user[links][0][url]', with: link_url

				first(:field, I18n.t('users.link.name')).value.should eq link_name 
				first(:field, I18n.t('users.link.url')).value.should eq link_url 

				first(:button, I18n.t('users.update')).click
				expect(page).to have_content link_name
				find_link(link_name)[:href].should eq link_url
				first(:link, link_name)[:href].should eq link_url
			end

			it 'should be able to submit one link without a prefix with description' do
				link_name = 'LinkedIn'
				link_url = 'www.linkedin.com'

				visit edit_user_path(id: @user.id)
				fill_in I18n.t('users.link.name'), with: link_name
				fill_in I18n.t('users.link.url'), with: link_url

				first(:button, I18n.t('users.update')).click
				expect(page).to have_content link_name
				find_link(link_name)[:href].should eq "http://#{link_url}"
				first(:link, link_name)[:href].should eq "http://#{link_url}"
			end
			it 'should not be able to submit one link without description' do
				link_url = 'www.linkedin.com'

				visit edit_user_path(id: @user.id)
				fill_in I18n.t('users.link.url'), with: link_url

				first(:button, I18n.t('users.update')).click

				expect(page).to have_content I18n.t('users.fail.no_description')
			end
			it 'should be able to submit two links with description', :js => true, vcr: {:record => :none} do
				link1_name = 'LinkedIn'
				link1_url = 'http://www.linkedin.com'
				link2_name = 'Google'
				link2_url = 'http://www.google.com'

				visit edit_user_path(id: @user.id)
				fill_in 'user[links][0][name]', with: link1_name
				fill_in 'user[links][0][url]', with: link1_url
				page.execute_script("$(\"input[name='user[links][0][name]']\").trigger(\"blur\")")
				fill_in 'user[links][1][name]', with: link2_name
				fill_in 'user[links][1][url]', with: link2_url

				first(:button, I18n.t('users.update')).click
				expect(page).to have_content link1_name
				expect(page).to have_content link2_name
				find_link(link1_name)[:href].should eq "#{link1_url}"
				first(:link, link1_name)[:href].should eq "#{link1_url}"
				find_link(link2_name)[:href].should eq "#{link2_url}"
				first(:link, link2_name)[:href].should eq "#{link2_url}"
			end
			it 'should not be able to submit two links without description'
			it 'should be not able to submit more than 5 links with description'
	end
end
