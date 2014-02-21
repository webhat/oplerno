class AddTransactionToOrderTransaction < ActiveRecord::Migration
  def change
    add_column :order_transactions, :txn_id, :string
  end
end
