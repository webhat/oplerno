class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :company_url
      t.string :logo_url

      t.timestamps
    end
    add_index :companies, :name, unique: true
  end
end
