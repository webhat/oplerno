class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :new
      t.integer :cart_id
      t.string :ip_address
      t.string :first_name
      t.string :last_name
      t.string :account

      t.timestamps
    end
  end
end
