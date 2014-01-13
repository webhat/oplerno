class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :cart
  has_many :transactions, :class_name => 'OrderTransaction'

  default_scope :order => 'created_at DESC'

  attr_accessible :ip, :transactions, :cart_id, :user_id

  def price_in_cents
    (cart.total_price*100).round
  end
end
