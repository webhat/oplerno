class AddCoursesAndUsersToCart < ActiveRecord::Migration
  def change
    add_column :carts, :courses, :int
    add_column :carts, :user, :int
  end
end
