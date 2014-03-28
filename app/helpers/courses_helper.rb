module CoursesHelper
  def has_course_image?
    @course.binary_data.nil?
  end
end
