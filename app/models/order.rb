class Order < ActiveRecord::Base
  belongs_to :cart
  has_many :transactions, :class_name => "OrderTransaction"

  validates :cart_id, presence: true, on: :create

  attr_accessible :account, :cart_id, :first_name, :ip_address, :last_name, :new

  def purchase
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
    cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end

  def price_in_cents
    (cart.total_price*100).round
  end

  private

  def purchase_options
    {
        :ip => ip_address,
        :billing_address => {
            :name     => "Ryan Bates",
            :address1 => "123 Main St.",
            :city     => "New York",
            :state    => "NY",
            :country  => "US",
            :zip      => "10001"
        }
    }
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
        :brand               => "visa",
        :number             => "4024007148673571",
        #:number             => "4024007148673576",
        :verification_value => "123",
        :month              => 1,
        :year               => Time.now.year+1,
        :first_name         => "Ryan",
        :last_name          => "Bates"
    )
  end
end
