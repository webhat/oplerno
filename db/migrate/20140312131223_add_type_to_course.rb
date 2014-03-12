class AddTypeToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :type, :string
  end
end
