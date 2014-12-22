class AddPrivateEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privateemail, :string
    add_index :users, :privateemail, :unique => true 
  end
end
