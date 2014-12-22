class ChangePasswordColumnToBinary < ActiveRecord::Migration
  def change
    change_column :users, :encrypted_password, :binary
  end
end
