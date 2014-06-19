class AddMaxAndMinToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :min, :int, default: 2
    add_column :courses, :max, :int, default: 25
  end
end
