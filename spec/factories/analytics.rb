# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :analytic do
    remote 'MyString'
    request 'MyString'
    time '2015-05-05'
    status 'MyString'
    bytes 'MyString'
    referer 'MyString'
    user_agent 'MyString'
  end
end
