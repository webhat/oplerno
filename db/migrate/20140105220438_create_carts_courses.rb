class CreateCartsCourses < ActiveRecord::Migration
  def change
    create_table :carts_courses do |t|
      t.belongs_to :cart
      t.belongs_to :course
    end
    add_index :carts_courses, :cart_id
    add_index :carts_courses, :course_id
    add_index :carts_courses, [:course_id, :cart_id], :unique => true
  end
end
