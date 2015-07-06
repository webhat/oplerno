class SubjectSlug < ActiveRecord::Migration
  def change
    add_column :subjects, :slug, :string
    add_index :subjects, :slug
  end
end
