class TeamsMentors < ActiveRecord::Base
  belongs_to :team
  belongs_to :mentor
end
