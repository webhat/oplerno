class CreateCoursesSkills < ActiveRecord::Migration
  def change
    create_table :courses_skills do |t|
      t.belongs_to :skill
      t.belongs_to :course

      t.timestamps
    end
    add_index :courses_skills, :skill_id
    add_index :courses_skills, :course_id
  end
end
