# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cart do  |f|
    f.total_price 5.00
  end
end
