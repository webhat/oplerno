class CreateCoursesUsers < ActiveRecord::Migration
  def change
    create_table :courses_users do |t|
      t.belongs_to :user
      t.belongs_to :course
    end
    add_index :courses_users, :user_id
    add_index :courses_users, :course_id
  end
end
