class Tag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :display_name, use: [:slugged, :history]

  has_and_belongs_to_many :mentors
  has_and_belongs_to_many :teams
  attr_accessible :name, :slug

  alias_attribute :display_name, :name
end
