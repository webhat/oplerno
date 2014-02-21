# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :carts_course, :class => 'CartsCourses' do
    cart nil
    course nil
  end
end
