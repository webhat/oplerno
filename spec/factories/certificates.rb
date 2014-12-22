FactoryGirl.define do
  factory :certificate do |f|
    f.name { Faker::Lorem.characters(8) }
  end
end
