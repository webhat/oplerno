class TagsTeams < ActiveRecord::Base
  belongs_to :team
  belongs_to :tag
  # attr_accessible :title, :body
end
