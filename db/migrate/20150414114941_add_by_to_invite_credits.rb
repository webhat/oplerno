class AddByToInviteCredits < ActiveRecord::Migration
  def change
    add_column :invite_credits, :by_id, :integer
  end
end
