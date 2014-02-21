class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.text :transactions
      t.belongs_to :cart
      t.string :ip

      t.timestamps
    end
    add_index :orders, :user_id
    add_index :orders, :cart_id
  end
end
