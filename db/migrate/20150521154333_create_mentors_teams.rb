class CreateMentorsTeams < ActiveRecord::Migration
  def change
    create_table :mentors_teams, id: false do |t|
      t.belongs_to :team
      t.belongs_to :mentor
    end
    add_index :mentors_teams, :team_id
    add_index :mentors_teams, :mentor_id
  end
end
