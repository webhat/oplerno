require 'spec_helper'

describe 'Visiting URLs' do
  before(:all) do
    I18n.locale = :en
	end

	let(:valid_user) { { title: 'King Maker', first_name: 'Check', last_name: 'Me', password: 'testtest', password_confirmation: 'testtest', email: 'teacher@oplerno.com' } }
	let(:valid_course) {{ name: 'Course Name', price: '1010' }}
  
	context 'while logged in' do
    before(:each) do
			@user = User.create! valid_user
			@user.confirm!

			@subject = Subject.create! subject: 'Test'
			@course = Course.new valid_course
			@course.teacher = @user.id
			@course.save

			visit '/users/sign_out'
			visit '/users/sign_in'
			fill_in I18n.t('devise.sessions.new.email'), with: @user.email
			fill_in I18n.t('devise.sessions.new.password'), with: 'testtest'
			click_button I18n.t('devise.sessions.new.sign_in')
    end

		after(:each) do
			@course.destroy
			Course.all.each { |course|
				course.destroy
			}
			@user.destroy
		end

		it 'should add subject to course' do
			visit "/courses/#{@course.id}/edit"
			fill_in I18n.t('name'), with: valid_course[:name]
			fill_in 'course_price', with: valid_course[:price]
			find(:css, "#subject_list_#{@subject.id}").set(true)

			first(:button, I18n.t('courses.update')).click
		end
		it 'should see subjects added to course' do
			visit "/courses/#{@course.id}"
			first(:link, 'Edit').click
			fill_in 'course_name', with: valid_course[:name]
			fill_in 'course_price', with: valid_course[:price]
			find(:css, "#subject_list_#{@subject.id}").set(true)

			first(:button, I18n.t('courses.update')).click

			visit '/subjects'

      expect(page).to have_content valid_course[:name]
		end
		it 'should create a new subject'
	end
end
