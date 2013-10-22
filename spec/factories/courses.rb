FactoryGirl.define do
  factory :course do      |f|
    f.name { Faker::Lorem.words }
  end
end
