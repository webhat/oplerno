class CreateCoursesTeachers < ActiveRecord::Migration
  def change
    create_table :courses_teachers do |t|
      t.belongs_to :course
      t.belongs_to :teacher
    end
    add_index :courses_teachers, :course_id
    add_index :courses_teachers, :teacher_id
    add_index :courses_teachers, [:teacher_id, :course_id], unique:true
  end
end
