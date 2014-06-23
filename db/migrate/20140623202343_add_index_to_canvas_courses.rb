class AddIndexToCanvasCourses < ActiveRecord::Migration
  def change
    add_index :canvas_courses, :canvas_id, :unique => true
  end
end
