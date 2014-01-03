class Cart < ActiveRecord::Base
  has_one :order
  has_many :courses

  attr_accessible :total_price, :purchased_at
end
