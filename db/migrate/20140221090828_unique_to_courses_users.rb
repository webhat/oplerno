class UniqueToCoursesUsers < ActiveRecord::Migration
  def up
    add_index :courses_users, [:user_id, :course_id], :unique => true
  end

  def down
    remove_index :courses_users, [:user_id, :course_id]
  end
end
