# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :canvas_course, :class => 'CanvasCourses' do
    name 'A Course'
    canvas_id 1
    course nil
  end
end
