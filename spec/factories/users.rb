FactoryGirl.define do
  factory :user do |f|
    f.email { Faker::Internet.free_email }
		f.privateemail { Faker::Internet.free_email }
    f.username { Faker::Internet.user_name }
    f.password { Faker::Lorem.characters(8) }
    f.password_confirmation { f.password }
    f.authy_enabled { false }
  end
end

