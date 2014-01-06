class AddCoursesAndUsersToCart < ActiveRecord::Migration
  def change
    add_column :carts, :user_id, :int
  end
end
