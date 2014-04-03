class AddLinksToUsers < ActiveRecord::Migration
  def change
    add_column :users, :links, :text
  end
end
