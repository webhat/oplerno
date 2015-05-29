# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :angel, :class => 'Angels' do
    user_id nil
    angelslug 'MyString'
    twitterslug 'MyString'
    adviser_to 'MyString'
    investor_in 'MyString'
  end
end
