class AddSyllabusToCanvasCourses < ActiveRecord::Migration
  def change
    add_column :canvas_courses, :syllabus, :text
  end
end
