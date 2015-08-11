class CreateCompaniesInvestors < ActiveRecord::Migration
  def change
    create_table :companies_investors do |t|
      t.belongs_to :angel
      t.belongs_to :company
    end
    add_index :companies_investors, :angel_id
    add_index :companies_investors, :company_id
    add_index :companies_investors, [:company_id, :angel_id], unique: true
  end
end
