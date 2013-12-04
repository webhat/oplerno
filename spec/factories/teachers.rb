FactoryGirl.define do
  factory :teacher do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.email { Faker::Internet.free_email }
    f.password { Faker::Lorem.characters(8) }
    f.password_confirmation { f.password }
    f.authy_enabled { false }
  end
end
