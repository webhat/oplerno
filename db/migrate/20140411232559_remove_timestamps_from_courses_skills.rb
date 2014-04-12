class RemoveTimestampsFromCoursesSkills < ActiveRecord::Migration
  def up
    remove_column :courses_skills, :created_at
    remove_column :courses_skills, :updated_at
  end

  def down
    add_column :courses_skills, :updated_at, :string
    add_column :courses_skills, :created_at, :string
  end
end
