class Team < ActiveRecord::Base
  extend FriendlyId
  friendly_id :display_name, use: [:slugged, :history]

  attr_accessible :description, :name, :slug
  attr_accessible :mentor_ids
  has_and_belongs_to_many :mentors
  has_and_belongs_to_many :tags

  alias_attribute :display_name, :name

  after_initialize :set_default_description

  def worked_with
    mentors.collect{ |m| m.worked_with }.reduce(:|) || []
  end

  def tags
    mentors.collect{ |m| m.tags }.reduce(:|) || []
  end

  private
  def set_default_description
    self.description ||= ''
  end
end
