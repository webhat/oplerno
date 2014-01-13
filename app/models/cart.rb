class Cart < ActiveRecord::Base
  has_one :order
  belongs_to :user
  has_and_belongs_to_many :courses

  default_scope :order => 'created_at DESC'

  attr_accessible :total_price, :purchased_at, :courses, :user_id

  def total_price
   courses.compact.map(&:price).inject(0, &:+)
  end
end
