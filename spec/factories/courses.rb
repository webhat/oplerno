FactoryGirl.define do
  factory :course do      |f|
    f.name { Faker::Lorem.sentence(3) }
    f.price { (500 * Faker::Number.digit.to_i) + 1000 }
  end
end
