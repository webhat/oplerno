class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.belongs_to :user
      t.string :code
      t.boolean :active

      t.timestamps
    end
    add_index :invites, :user_id, unique: true
  end
end
