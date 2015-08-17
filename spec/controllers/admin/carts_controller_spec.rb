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
      skip
      get :index
      expect(assigns(:carts)).to_not eq nil
    end

    it "shows the record" do
      get :show, :id => @cart.id
      expect(assigns(:cart)).to eq(@cart)
    end
  end
end
