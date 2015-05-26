class CreateMentors < ActiveRecord::Migration
  def change
    create_table :mentors do |t|

      t.timestamps
    end
  end
end
