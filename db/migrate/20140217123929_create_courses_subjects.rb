class CreateCoursesSubjects < ActiveRecord::Migration
  def change
    create_table :courses_subjects do |t|
      t.belongs_to :subject
      t.belongs_to :course
    end
    add_index :courses_subjects, :subject_id
    add_index :courses_subjects, :course_id
    add_index :courses_subjects, [:course_id, :subject_id], :unique => true
  end
end
