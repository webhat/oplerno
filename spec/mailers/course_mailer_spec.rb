require 'spec_helper'

describe CourseMailer do
  it 'should send an email to the admin' do
    user = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    course.teacher = user.id
    course.save
    course_mail = CourseMailer.new_teacher(course)

    expect(course_mail.from[0]).to eq('webmaster@oplerno.com')
    expect(course_mail.to[0]).to eq(user.email)

    course_mail.deliver
    ActionMailer::Base.deliveries.should_not be_empty
  end
end
