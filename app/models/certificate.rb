class Certificate < ActiveRecord::Base
  attr_accessible :name
	has_and_belongs_to_many :courses
	belongs_to :teacher

	paginates_per 24

	validates_presence_of :name
end
