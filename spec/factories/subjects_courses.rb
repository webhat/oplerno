# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subjects_course, :class => 'SubjectsCourses' do
    subjects nil
    courses nil
  end
end
