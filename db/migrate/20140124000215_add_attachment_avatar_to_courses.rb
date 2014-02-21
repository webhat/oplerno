class AddAttachmentAvatarToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :courses, :avatar
  end
end
