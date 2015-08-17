require 'spec_helper'

describe Cart do
  it "has a valid factory" do
    expect( FactoryGirl.create(:cart) ).to be_valid
  end

  it 'checks the amounts in the basket add up' do
    course1 = FactoryGirl.build(:course, price: 1000, name: 'course1')
    course2 = FactoryGirl.build(:course, price: 500, name: 'course2')

    cart = FactoryGirl.build(:cart, courses: [course1, course2])

    expect( cart.total_price ).to eq 1500.00
  end
end
