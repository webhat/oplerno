class AddSecretMoreColumnsToOrderTransaction < ActiveRecord::Migration
  def change
    add_column :order_transactions, :params_completed, :binary
    add_column :order_transactions, :params_completed_key, :binary
    add_column :order_transactions, :params_completed_iv, :binary
  end
end
