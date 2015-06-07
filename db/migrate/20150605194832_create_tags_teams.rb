class CreateTagsTeams < ActiveRecord::Migration
  def change
    create_table :tags_teams do |t|
      t.belongs_to :team
      t.belongs_to :tag

      t.timestamps
    end
    add_index :tags_teams, :team_id
    add_index :tags_teams, :tag_id
    add_index :tags_teams, [:tag_id, :team_id], unique: true
  end
end
