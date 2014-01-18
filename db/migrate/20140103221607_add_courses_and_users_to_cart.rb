class AddCoursesAndUsersToCart < ActiveRecord::Migration
  def change
    add_column :carts, :user_id, :integer
    add_index :carts, :user_id
  end
end
