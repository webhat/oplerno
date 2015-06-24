require 'spec_helper'

describe CourseMailer do
  it 'should send an email to the admin' do
    teacher = FactoryGirl.create(:teacher)
    course = FactoryGirl.create(:course)
    course.teachers << teacher
    course.save
    course_mail = CourseMailer.new_teacher(course)

    expect(course_mail.from[0]).to eq('webmaster@oplerno.com')
    expect(course_mail.to[0]).to eq(teacher.email)

    course_mail.deliver
    ActionMailer::Base.deliveries.should_not be_empty
  end
end
