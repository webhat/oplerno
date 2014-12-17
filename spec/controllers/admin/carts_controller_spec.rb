require 'spec_helper'


describe Admin::CartsController, :type => :controller do
  render_views
  login_admin

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe 'Get carts' do
    let(:valid_attributes) { {} }

    before(:each) do
      @cart = Cart.create! valid_attributes
      @cart.user = @user
    end

    after(:each) do
      @cart.destroy
    end

    it "gets the index" do
      get :index
      assigns(:carts).should_not eq nil
    end

    it "shows the record" do
      get :show, :id => @cart.id
      assigns(:cart).should eq(@cart)
    end
  end
end
