# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do
    email { Faker::Internet.free_email }
    password { Faker::Lorem.characters(8) }
    password_confirmation { password }
  end
end
