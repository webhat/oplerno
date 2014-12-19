class AddSlugToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :slug, :string
    add_index :certificates, :slug
  end
end
