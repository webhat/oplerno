class CreateSubjectsCourses < ActiveRecord::Migration
  def change
    create_table :subjects_courses do |t|
      t.belongs_to :subjects
      t.belongs_to :courses

      t.timestamps
    end
    add_index :subjects_courses, :subjects_id
    add_index :subjects_courses, :courses_id
  end
end
