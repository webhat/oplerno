class IndexCoursesSkills < ActiveRecord::Migration
  def change
    add_index :courses_skills, [:course_id, :skill_id], :unique => true
  end
end
