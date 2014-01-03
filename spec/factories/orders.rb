# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    new "MyString"
    cart_id { Faker::Number.digit }
    ip_address "MyString"
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    account "MyString"
  end
end
