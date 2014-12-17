class AddSecretColumnsToOrderTransaction < ActiveRecord::Migration
  def change
    change_column :order_transactions, :params, :binary
    add_column :order_transactions, :params_key, :binary
    add_column :order_transactions, :params_iv, :binary
  end
end
