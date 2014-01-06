class AddCoursesAndUsersToCart < ActiveRecord::Migration
  def change
    add_column :carts, :user_id, :belongs_to
  end
end
