class CreateCertificatesCourses < ActiveRecord::Migration
  def change
    create_table :certificates_courses do |t|
      t.belongs_to :course
      t.belongs_to :certificate
    end
    add_index :certificates_courses, :course_id
    add_index :certificates_courses, :certificate_id
  end
end
