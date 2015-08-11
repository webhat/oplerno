# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teams_mentor, :class => 'TeamsMentors' do
    team nil
    mentor nil
  end
end
