require 'spec_helper'


describe Admin::OrderTransactionsController do
  render_views
  login_admin

  before(:each) do
    @cart = FactoryGirl.create(:cart)
    @cart.user = FactoryGirl.create(:user)
    @cart.save
    @order = FactoryGirl.build(:order, {cart_id: @cart.id, user_id: @cart.user.id})
  end

  describe 'Get order_transactions' do
    let(:valid_attributes) { {order_id: @order.id} }

    before(:each) do
      @order_transaction = OrderTransaction.create! valid_attributes
      @order_transaction.order = @order
      @order_transaction.save
    end

    after(:each) do
      @order_transaction.destroy
    end

    it "gets the index" do
      get :index
      assigns(:order_transactions).should_not eq nil
    end

    it "shows the record" do
      get :show, :id => @order_transaction.id
      assigns(:order_transaction).should eq(@order_transaction)
    end
  end
end