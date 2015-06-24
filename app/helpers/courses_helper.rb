module CoursesHelper
  def has_course_image?
    @course.binary_data.nil?
  end

  def course_cache_id course=@course
    if current_user.nil?
      "#{prefix}_#{cache_id}_#{ course.id }"
    else
      "#{prefix}_#{cache_id}_#{ course.id }_#{current_user.id}"
    end
  end

  def prefix
    if @courses.nil?
      'course'
    else
      'courses'
    end
  end

  def teachers_course?
    user_signed_in? && @course.course_teacher?( current_user )
  end
end
