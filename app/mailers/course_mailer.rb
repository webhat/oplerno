class CourseMailer < ActionMailer::Base
  @from = 'webmaster@oplerno.com'
  default from: @from, to: @from

  layout 'email'

  def new_teacher course
    @course = course
    @teacher = Teacher.find(course.teacher)

    mail(subject: t('courses.new_teacher'),
         to: @teacher.email
        )

    self
  end
end
