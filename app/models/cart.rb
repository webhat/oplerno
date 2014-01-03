class Cart < ActiveRecord::Base
  has_one :order
  belongs_to :user
  has_many :courses, through: :user

  attr_accessible :total_price, :purchased_at

  def total_price
    courses.map(&:price).inject(0, &:+)
  end
end
