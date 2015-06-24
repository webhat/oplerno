class CoursesTeacher < ActiveRecord::Base
  belongs_to :courses
  belongs_to :teachers
  # attr_accessible :title, :body
end
