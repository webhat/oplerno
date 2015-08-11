class CreateAdvisorCompanies < ActiveRecord::Migration
  def change
    create_table :advisors_companies do |t|
      t.belongs_to :angel
      t.belongs_to :company
    end
    add_index :advisors_companies, :angel_id
    add_index :advisors_companies, :company_id
    add_index :advisors_companies, [:company_id, :angel_id], unique: true
  end
end
