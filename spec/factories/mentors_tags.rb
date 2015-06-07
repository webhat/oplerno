# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mentors_tag, :class => 'MentorsTags' do
    team nil
    tag nil
  end
end
