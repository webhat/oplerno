require 'spec_helper'

describe Order do
  it "has a valid factory" do
    FactoryGirl.create(:order).should be_valid
  end
  it "is invalid without a total price" do
    FactoryGirl.build(:order, cart: nil).should_not be_valid
  end

  it 'checks the amount' do
    cart = FactoryGirl.create(:cart, total_price: 6.00)
    order = FactoryGirl.create(:order, cart: cart)

    order.price_in_cents.should eq 600
  end
end
