class CreateTeacherRankings < ActiveRecord::Migration
  def change
    create_table :teacher_rankings do |t|
      t.belongs_to :teacher
      t.integer :ranking

      t.timestamps
    end

    add_index :teacher_rankings, :teacher_id, :unique => true 
  end
end
