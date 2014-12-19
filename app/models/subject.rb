class Subject < ActiveRecord::Base
  attr_accessible :subject
  validates_presence_of :subject

  has_and_belongs_to_many :courses
end
