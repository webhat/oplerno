require 'spec_helper'


describe Admin::OrderTransactionsController do
  render_views
  login_admin

  before(:each) do
    @cart = FactoryGirl.create(:cart)
    @cart.user = FactoryGirl.create(:user)
    @cart.save
    built_order = {cart_id: @cart.id, user_id: @cart.user.id}
    @order = FactoryGirl.build(:order, built_order)
    @order.save
  end

  describe 'Get order_transactions' do
    let(:valid_order_transaction) {{ }}

    before(:each) do
      @order_transaction = OrderTransaction.create! valid_order_transaction
      @order_transaction.order = @order
      @order_transaction.params = '{"payer": "observer@oplerno.com"}'
      @order_transaction.save
    end

    after(:each) do
      @order_transaction.destroy
    end

    context 'index' do
      it 'gets the index' do
        get :index
        assigns(:order_transactions).should_not eq nil
      end
    end

    context 'show' do
      it 'shows the record' do
        get :show, :id => @order_transaction.id
        assigns(:order_transaction).should eq(@order_transaction)
      end

      it 'verifies the record has an order' do
        get :show, :id => @order_transaction.id
        assigns(:order_transaction).order.should eq(@order)
      end
    end
  end
end
