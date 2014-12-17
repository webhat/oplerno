class ChangeSizeOfDescription < ActiveRecord::Migration
  def up
    change_column :users, :description, :text
    change_column :courses, :description, :text
  end

  def down
    change_column :users, :description, :string
    change_column :courses, :description, :string
  end
end
