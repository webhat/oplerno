class AddAttachmentMontageToCertificates < ActiveRecord::Migration
  def self.up
    change_table :certificates do |t|
      t.attachment :montage
    end
  end
  def self.down
    drop_attached_file :certificates, :montage
  end
end
