require 'spec_helper'

describe Admin::OrdersController do
  render_views
  login_admin

  before do
    @cart = FactoryGirl.create(:cart)
    @cart.user = FactoryGirl.create(:user)
    @cart.save
  end

  describe 'Get orders' do
    let(:valid_order) { {} }

    before do
      @order = @cart.build_order(valid_order)
      @order.save
    end

    after do
      @order.destroy
    end

    it "gets the index" do
      skip
      get :index
      expect(assigns(:orders)).to_not eq nil
    end

    it "shows the record" do
      get :show, { :id => @order.to_param }
      expect(assigns(:order)).to eq(@order)
    end
  end
end
