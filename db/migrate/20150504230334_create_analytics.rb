class CreateAnalytics < ActiveRecord::Migration
  def change
    create_table :analytics do |t|
      t.string :remote
      t.string :request
      t.datetime :time
      t.string :status
      t.string :bytes
      t.string :referer
      t.string :user_agent
      t.string :method
      t.string :path
      t.string :protocol

      t.timestamps
    end
    add_index :analytics, :path
    add_index :analytics, :time
    add_index :analytics, [:remote, :path, :time], unique: true
  end
end
