class CertificatesCourses < ActiveRecord::Base
  belongs_to :course
  belongs_to :certificate
end
