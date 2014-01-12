require 'spec_helper'


describe Admin::OrdersController do
  render_views
  login_admin

  before(:each) do
    @user = FactoryGirl.create(:user)
    @cart = FactoryGirl.create(:cart)
  end

  describe 'Get orders' do
    let(:valid_attributes) { {cart_id: @cart.id, user_id: @user.id} }

    before(:each) do
      @order = Order.create! valid_attributes
    end

    after(:each) do
      @order.destroy
    end

    it "gets the index" do
      get :index
      assigns(:orders).should_not eq nil
    end

    it "shows the record" do
      get :show, :id => @order.id
      assigns(:order).should eq(@order)
    end
  end
end