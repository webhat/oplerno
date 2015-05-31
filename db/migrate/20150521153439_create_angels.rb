class CreateAngels < ActiveRecord::Migration
  def change
    create_table :angels do |t|
      t.belongs_to :mentor
      t.string :angelslug
      t.string :twitterslug
      t.string :adviser_to
      t.string :investor_in

      t.timestamps
    end
    add_index :angels, :mentor_id
  end
end
