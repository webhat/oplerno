class Subject < ActiveRecord::Base
	attr_accessible :subject
  validates_presence_of :subject
end
