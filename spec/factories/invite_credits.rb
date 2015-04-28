# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invite_credit do
    user nil
    amount 1
    used false
  end
end
