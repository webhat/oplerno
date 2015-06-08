# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tags_team, :class => 'TagsTeams' do
    team nil
    tag nil
  end
end
