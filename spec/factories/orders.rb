# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    user nil
    transactions []
    cart nil
    ip { Faker::Internet.ip_v4_address }
  end
end
