class AddDeletedAtToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :deleted_at, :datetime
    add_index :admin_users, :deleted_at
  end
end
