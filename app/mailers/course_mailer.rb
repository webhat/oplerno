class CourseMailer < ActionMailer::Base
  @from = 'webmaster@oplerno.com'
  default from: @from, to: @from

  layout 'email'

  def new_teacher course
    @course = course
    @teacher = Teacher.find(course.teacher)

    subject = t('courses.new_teacher', display_name: course.display_name)
    mail(subject: subject,
         to: @teacher.email
        )

    self
  end
end
