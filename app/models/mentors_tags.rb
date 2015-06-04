class MentorsTags < ActiveRecord::Base
  belongs_to :mentor
  belongs_to :tag
  # attr_accessible :title, :body
end
