class AddMoreSecretColumnsToUser < ActiveRecord::Migration
  def change
    change_column :users, :title, :binary
    add_column :users, :title_key, :binary
    add_column :users, :title_iv, :binary

    change_column :users, :first_name, :binary
    add_column :users, :first_name_key, :binary
    add_column :users, :first_name_iv, :binary

    change_column :users, :last_name, :binary
    add_column :users, :last_name_key, :binary
    add_column :users, :last_name_iv, :binary
  end
end
