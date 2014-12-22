require 'spec_helper'

describe OrdersHelper do
  before do
    @cart = FactoryGirl.create(:cart)
    @cart.create_order!
    assign(:cart, @cart)
  end
  it '#current_cart' do
    expect(@cart).to eq helper.current_cart
  end
  it '#current_order' do
    expect(@cart.order).to eq helper.current_order
  end
end
