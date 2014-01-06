class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :key
      t.integer :price
      t.string :description
      t.string :teacher
      t.string :filename
      t.string :content_type
      t.string :binary_data

      t.timestamps
    end
  end
end
