class Team < ActiveRecord::Base
  attr_accessible :description, :name
  attr_accessible :mentor_ids
  has_and_belongs_to_many :mentors

  alias_attribute :display_name, :name

  def tags
    mentors.collect{ |m| m.tags }.reduce(:|) || []
  end
end
