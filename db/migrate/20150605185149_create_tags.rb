class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end
    add_column :tags, :slug, :string
    add_index :tags, :slug
  end
end
