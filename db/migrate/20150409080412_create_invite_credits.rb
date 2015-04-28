class CreateInviteCredits < ActiveRecord::Migration
  def change
    create_table :invite_credits do |t|
      t.belongs_to :user
      t.integer :amount
      t.boolean :used

      t.timestamps
    end
    add_index :invite_credits, :user_id
  end
end
