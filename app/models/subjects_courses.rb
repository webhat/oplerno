class SubjectsCourses < ActiveRecord::Base
  belongs_to :subjects
  belongs_to :courses
end
