class MoveCourseTeacherToNewTable < ActiveRecord::Migration
  def up
    Course.find_each do |course|
      course.teachers << Teacher.find(course.teacher) unless course.teacher.nil?
    end
  end
  def down
    CoursesTeacher.find_each do |course|
      course.destroy
    end
  end
end
