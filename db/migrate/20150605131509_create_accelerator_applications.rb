class CreateAcceleratorApplications < ActiveRecord::Migration
  def change
    create_table :accelerator_applications do |t|
      t.string :description
      t.string :email
      t.belongs_to :team
      t.belongs_to :mentor

      t.timestamps
    end
    add_index :accelerator_applications, :team_id
    add_index :accelerator_applications, :mentor_id
  end
end
