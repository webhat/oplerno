class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :subject
    end
    add_index :subjects, :subject, :unique => true
  end
end
