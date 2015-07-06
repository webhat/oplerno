class Tag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :display_name, use: [:slugged, :history]
  # TODE: versions in here

  has_and_belongs_to_many :mentors
  has_and_belongs_to_many :teams
  attr_accessible :name, :slug, :mentor_id

  alias_attribute :display_name, :name

  def clean_tag
     {id: self.id, name: self.name }
  end
end
