class SubjectsCourses < ActiveRecord::Base
  belongs_to :subjects
  belongs_to :courses
  # attr_accessible :title, :body
end
