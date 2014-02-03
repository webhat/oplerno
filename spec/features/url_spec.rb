require 'spec_helper'

describe 'Visiting URLs' do
  before(:all) do
    I18n.locale = :en
  end

  let(:valid_course) { {name: 'A course that cant be confused', price: '101'} }

  context 'while logged in' do
    before (:each) do
			@user = FactoryGirl.build(:user, password: 'testtest')
			@user.confirm!

			valid_course[:teacher] = @user.id

			visit '/users/sign_out'
			visit '/users/sign_in'
			fill_in I18n.t('devise.sessions.new.email'), with: @user.email
			fill_in I18n.t('devise.sessions.new.password'), with: 'testtest'
			click_button I18n.t('devise.sessions.new.sign_in')
      @course = Course.create! valid_course
			@user.courses << @course
    end

    after (:each) do
      Cart.all.each { |cart|
				cart.courses.clear
			}
      Course.all.each { |course|
				course.delete
			}
    end

    it 'should be able to visit the courses and pick a course' do
      visit '/courses'
      expect(page).to have_content I18n.t('courses.view')
      find(:xpath, "(//a[text()='#{I18n.t('courses.view')}'])[1]").click
    end
    it 'should be able to visit the courses and register a course' do
      visit '/courses'
      expect(page).to have_content I18n.t('courses.view')
      find(:xpath, "(//a[text()='#{I18n.t('courses.view')}'])[1]").click

      # Register Page
      expect(page).to have_content I18n.t('courses.register')
      click_button I18n.t('courses.register')

			visit '/carts/mycart'
      expect(page).to have_content valid_course[:name]
    end
    it 'should be able to visit the courses and pick a teacher' do
      visit '/courses'
      expect(page).to have_content I18n.t('courses.view')
      find(:xpath, "(//a[text()='#{I18n.t('courses.view')}'])[1]").click

      # View Teacher
			expect(page).to have_content @user.encrypted_first_name
			find("div.teacher_image_small").click

      expect(page).to have_content @user.encrypted_first_name
      expect(page).to have_content @user.encrypted_last_name
    end
    it 'should be able to visit the teachers and pick a course' do
      visit '/courses'
      expect(page).to have_content I18n.t('courses.view')
      find(:xpath, "(//a[text()='#{I18n.t('courses.view')}'])[1]").click

      # View Teacher
      expect(page).to have_content I18n.t('courses.view')
      click_link I18n.t('courses.view')

      expect(page).to have_content @user.encrypted_first_name
      expect(page).to have_content @user.encrypted_last_name
    end
    it 'should be able to visit the teachers and pick a teacher' do
			visit '/teachers/'
      expect(page).to have_content @user.encrypted_first_name
      expect(page).to have_content @user.encrypted_last_name
      find(:xpath, "(//a[text()='#{I18n.t('users.view')}'])[1]").click

      expect(page).to have_content @user.encrypted_first_name
      expect(page).to have_content @user.encrypted_last_name
		end
    it 'should be able to visit the cart and remove a course' do
      visit '/courses'
      find(:xpath, "(//a[text()='#{I18n.t('courses.view')}'])[1]").click
      click_button I18n.t('courses.register')

			visit '/carts/mycart'
      expect(page).to have_content valid_course[:name]
			page.all('.col-6').count.should eq 1

			click_button I18n.t('cart.remove')
			expect(page).to have_content I18n.t('cart.removed', {course: valid_course[:name]})
			page.all('.col-6').count.should eq 0
		end
  end
end
