class AddTeacherToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :teacher_id, :int
  end
end
