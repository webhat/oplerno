# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :courses_user, :class => 'CoursesUsers' do
    user nil
    course nil
  end
end
