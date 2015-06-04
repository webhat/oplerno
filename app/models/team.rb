class Team < ActiveRecord::Base
  extend FriendlyId
  friendly_id :display_name, use: [:slugged, :history]

  attr_accessible :description, :name, :slug
  attr_accessible :mentor_ids
  has_and_belongs_to_many :mentors

  alias_attribute :display_name, :name

  def tags
    mentors.collect{ |m| m.tags }.reduce(:|) || []
  end
end
