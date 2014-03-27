class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :description
      t.string :hidden
      t.string :filename
      t.string :content_type
      t.string :binary_data

      t.timestamps
    end
  end
end
