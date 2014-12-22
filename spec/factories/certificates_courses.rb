# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :certificates_course, :class => 'CertificatesCourses' do
    course nil
    certificate nil
  end
end
