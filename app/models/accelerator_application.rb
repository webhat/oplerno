class AcceleratorApplication < ActiveRecord::Base
  belongs_to :team
  belongs_to :mentor
  attr_accessible :description, :email
end
