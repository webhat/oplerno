class CreateCourseRankings < ActiveRecord::Migration
  def change
    create_table :course_rankings do |t|
      t.belongs_to :course
      t.integer :ranking

      t.timestamps
    end
    add_index :course_rankings, :course_id, unique: true
  end
end
