class Subject < ActiveRecord::Base
  extend FriendlyId
  friendly_id :subject, use: [:slugged, :history]

  attr_accessible :subject
  validates_presence_of :subject

  has_and_belongs_to_many :courses
end
