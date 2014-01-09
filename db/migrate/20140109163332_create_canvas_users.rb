class CreateCanvasUsers < ActiveRecord::Migration
  def change
    create_table :canvas_users do |t|
      t.belongs_to :user
      t.text :avatal_url
      t.integer :canvas_id
      t.text :locale
      t.text :username

      t.timestamps
    end
    add_index :canvas_users, :user_id
    add_index :canvas_users, :username
  end
end
