class Cart < ActiveRecord::Base
  has_one :order
  belongs_to :user
  has_and_belongs_to_many :courses

  attr_accessible :total_price, :purchased_at, :courses, :user_id

  def total_price
   courses.map(&:price).inject(0, &:+)
  end
end
