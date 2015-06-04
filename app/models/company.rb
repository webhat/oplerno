class Company < ActiveRecord::Base
  has_and_belongs_to_many :advisors, class_name: 'Angel'
  has_and_belongs_to_many :investors, class_name: 'Angel'
  attr_accessible :name, :company_url, :logo_url
end
