require 'spec_helper'

describe Order do
  it "has a valid factory" do
    FactoryGirl.create(:order).should be_valid
  end
  it "is invalid without a total price" do
    FactoryGirl.build(:order, cart: nil).should_not be_valid
  end

  it 'checks the amount' do
    course1 = FactoryGirl.build(:course, price: 600, name: 'course1')
    cart = FactoryGirl.build(:cart, courses: [course1])
    order = FactoryGirl.build(:order, cart: cart)

    order.price_in_cents.should eq 60000
  end
end
