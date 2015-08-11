class CourseObserver < ActiveRecord::Observer
  def after_create(course)
    update_rank course
  end

  def after_save course
    update_rank course

    #CourseMailer.new_teacher(course).deliver if course.teacher_changed?
  end

  def update_rank course
    course.create_rank if course.rank.nil?
    course.rank.course = course

    course.rank.rank
    course.rank.save
  end
end
