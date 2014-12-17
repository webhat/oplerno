class AddSecretColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :secret, :binary
    add_column :users, :secret_key, :binary
    add_column :users, :secret_iv, :binary
  end
end
