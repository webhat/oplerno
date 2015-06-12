require 'spec_helper'

describe 'Visiting URLs' do
  before(:all) do
    I18n.locale = :en
  end

  let(:valid_course) { {name: 'A course that cant be confused', price: '101', hidden: false} }
  let(:valid_user) { { title: 'King Maker', first_name: 'Check', last_name: 'Me', password: 'testtest', password_confirmation: 'testtest', email: 'teacher@oplerno.com' } }

  context 'while logged in' do
    before (:each) do
      @user = Teacher.create! valid_user
      @user.confirm!

      visit '/users/sign_out'
      visit '/users/sign_in'
      fill_in I18n.t('devise.sessions.new.email'), with: @user.email
      fill_in I18n.t('devise.sessions.new.password'), with: 'testtest'
      click_button I18n.t('devise.sessions.new.sign_in')
      @course = Course.create! valid_course

      @user.save
    end

    after (:each) do
      Cart.find_each { |cart|
        cart.courses.clear
      }
      User.find_each { |user|
        user.delete
      }
      Course.find_each { |course|
        course.delete
      }
    end

    context 'wih Teacher' do
      it 'should be able to visit the courses and register for a course' do
        @course.teachers << @user

        visit '/courses'
        first('.course > a').click

        # Register Page
        first(:xpath, "//*[@value='#{I18n.t('courses.register')}'][1]").click

        visit '/carts/mycart'
        expect(page).to have_content valid_course[:name]
      end
      it 'should be able to visit the courses and pick a teacher' do
        @course.teachers << @user
        visit '/courses'
        page.first(".course > a").click

        # View Teacher
        expect(page).to have_content @user.encrypted_first_name
        find(".teacher > a").click

        expect(page).to have_content @user.encrypted_first_name
        expect(page).to have_content @user.encrypted_last_name
      end
      it 'should be able to visit the teachers and pick a course' do
        @course.teachers << @user

        visit '/teachers'
        page.first('.teacher > a').click

        # View Course
        expect(page).to have_content @course.name
        page.first(".course > a").click

        expect(page).to have_content @course.name
      end
      it 'should be able to visit the cart and remove a course' do
        @course.teachers << @user

        visit '/courses'
        page.first(".course > a").click

        # Register Page
        expect(page.current_path).to eq "/courses/#{@course.slug}"
        expect(page).to have_content valid_course[:name]
        first(:xpath, "//*[@value='#{I18n.t('courses.register')}']").click
        expect(page.current_path).to eq '/courses'

        visit '/carts/mycart'
        expect(page).to have_content valid_course[:name]

        click_button I18n.t('cart.remove')
        expect(page).to have_content I18n.t('cart.removed', {course: valid_course[:name]})
      end
    end
    context 'without Teacher' do
      it 'should be able to visit the courses and pick a course' do
        visit '/courses'
        page.first(".course > a").click
      end
      it 'should be able to visit the teachers and pick a teacher' do
        visit '/teachers/'
        expect(page).to have_content @user.encrypted_first_name
        expect(page).to have_content @user.encrypted_last_name
        page.first(".teacher > a").click

        expect(page).to have_content @user.encrypted_first_name
        expect(page).to have_content @user.encrypted_last_name
      end
      it 'shouldn\'t be able to take course when full' do
        @course.max = 0
        @course.save

        visit '/courses'
        page.first(".course > a").click

        # Register Page
        expect(page.current_path).to eq "/courses/#{@course.slug}"
        expect(page).to have_content valid_course[:name]
        first(:xpath, "//*[@value='#{I18n.t('courses.register')}']").click
        expect(page.current_path).to eq '/courses'

        expect(page).to have_content I18n.t('courses.fail.too_many')
      end
      it 'shouldn\'t be able to take course again' do
        @user.courses << @course

        visit '/courses'
        page.first(".course > a").click

        # Register Page
        expect(page.current_path).to eq "/courses/#{@course.slug}"
        expect(page).to have_content valid_course[:name]
        first(:xpath, "//*[@value='#{I18n.t('courses.register')}']").click
        expect(page.current_path).to eq '/courses'

        expect(page).to have_content I18n.t('courses.fail.already_in')
      end
    end
  end
end
