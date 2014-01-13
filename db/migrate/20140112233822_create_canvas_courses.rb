class CreateCanvasCourses < ActiveRecord::Migration
  def change
    create_table :canvas_courses do |t|
      t.text :name
      t.integer :canvas_id
      t.belongs_to :course

      t.timestamps
    end
    add_index :canvas_courses, :name, :length => {:name => 64}
  end
end
