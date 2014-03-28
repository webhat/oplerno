class CoursesSkills < ActiveRecord::Base
  belongs_to :skill
  belongs_to :course
  # attr_accessible :title, :body
end
