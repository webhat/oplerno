class FixFieldLength < ActiveRecord::Migration
  def up
    change_column :teams, :description, :text
  end
  def down
    # This might cause trouble if you have strings longer
    #     # than 255 characters.
    change_column :teams, :description, :string
  end
end
