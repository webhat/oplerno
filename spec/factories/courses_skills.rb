# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :courses_skill, :class => 'CoursesSkills' do
    skill nil
    course nil
  end
end
