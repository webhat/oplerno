FactoryGirl.define do
  factory :user do |f|
    f.email { Faker::Internet.free_email }
    f.password { Faker::Lorem.characters(8) }
    f.password_confirmation { f.password }
    f.authy_enabled { false }
  end
end

