class CreateMentorsTags < ActiveRecord::Migration
  def change
    create_table :mentors_tags do |t|
      t.belongs_to :mentor
      t.belongs_to :tag
    end
    add_index :mentors_tags, :mentor_id
    add_index :mentors_tags, :tag_id
    add_index :mentors_tags, [:tag_id, :mentor_id], unique: true
  end
end
