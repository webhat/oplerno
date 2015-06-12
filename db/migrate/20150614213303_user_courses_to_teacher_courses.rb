class UserCoursesToTeacherCourses < ActiveRecord::Migration
  def up
    CoursesUsers.find_each do |cu|
      begin
        CoursesTeacher.create! teacher_id: cu.user_id, course_id: cu.course_id
      rescue
        p "Failed to migrate course: #{cu.course_id} with teacher: #{cu.user_id}"
      end
    end
  end

  def down
  end
end
