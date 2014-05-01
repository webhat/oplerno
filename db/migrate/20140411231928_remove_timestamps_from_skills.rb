class RemoveTimestampsFromSkills < ActiveRecord::Migration
  def up
    remove_column :skills, :created_at
    remove_column :skills, :updated_at
  end

  def down
    add_column :skills, :updated_at, :string
    add_column :skills, :created_at, :string
  end
end
