require 'spec_helper'

describe OrdersController do
  login_user

  let(:valid_attributes) { {} }

  let(:valid_session) { {} }

  let (:valid_cart) { { total_price: 6.00 } }

  before(:each) do
    @cart = Cart.create! valid_cart
    @cart.user = current_user
    @cart.save
  end

  describe 'GET new' do
    it 'assigns a new order as @order' do
      get :new, {}
      expect(assigns(:order)).to be_a_new(Order)
    end
  end

  describe 'POST create' do
    vcr_options = {:record => :once}
    describe 'with valid params', :vcr => vcr_options do
      it 'creates a new Order' do
        expect {
          post :create, {:order => valid_attributes}
        }.to change(Order, :count).by(1)
      end

      it 'assigns a newly created order as @order' do
        post :create, {:order => valid_attributes}
        expect(assigns(:order)).to be_a(Order)
        expect(assigns(:order)).to be_persisted
      end

      it 'redirects to the created order' do
        post :create, {:order => valid_attributes}
        expect(response.status).to eq 302
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved order as @order' do
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(Order).to receive(:save).and_return(false)
        post :create, {:order => {}}
        expect(assigns(:order)).to be_a_new(Order)
      end

      it 're-renders the "new" template' do
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(Order).to receive(:save).and_return(false)
        post :create, {:order => {}}
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET confirm' do
    let(:valid_params) {
      {
        :id => nil,
        :token => 'EC-59R59009BF276314F',
        :PayerID => 'H7E8K2LT573UN',
        :order_total => 750.00
      }
    }

    vcr_options = {:record => :once, :allow_playback_repeats => true}
    context 'Something', vcr: vcr_options do
      before :each do
        expect_any_instance_of(Order).to receive(:price_in_cents).and_return(1000*100)
        @cart = Cart.create!
        @cart.user = FactoryGirl.create(:user)
        order = @cart.build_order
        order.save
        valid_params[:id] = order.id
        expect_any_instance_of(OrdersController).to receive(:current_cart).at_least(1).and_return(@cart)
      end
      it 'create any error state' do
        err = ActiveMerchant::Billing::PaypalExpressResponse.new false, 'Error'
        expect_any_instance_of(ActiveMerchant::Billing::PaypalExpressGateway).to receive(:details_for).and_return(err)
        get :confirm, valid_params
        @cart.reload
        expect(@cart.order).to be_a Order
        expect(@cart.order.transactions[0]).to be_a OrderTransaction
        expect(@cart.order.transactions[0].success).to eq false
      end
      it 'succeeds' do
        get :confirm, valid_params
        @cart.reload
        expect(@cart.order).to be_a Order
        expect(@cart.order.transactions[0]).to be_a OrderTransaction
        expect(@cart.order.transactions[0].success).to eq true
      end
    end
  end

  describe 'Set order' do
    vcr_options = {:record => :once}
    context 'with vcr and', vcr: vcr_options do
      it 'should set a cart without params' do
        expect_any_instance_of(OrdersController).to receive(:purchase)
        controller.send(:set_order)
        expect(assigns(:order)).to be_a Order
      end
      it 'should set a cart with params' do
        expect_any_instance_of(OrdersController).to receive(:purchase)
        controller.params[:order] = {  }
        controller.send(:set_order)
        expect(assigns(:order)).to be_a Order
      end
      it 'should not set a cart based on current_cart is nil' do
        expect_any_instance_of(OrdersController).to receive(:current_cart).and_return(nil)
        #expect_any_instance_of(OrdersController).to receive(:purchase)
        expect {
          controller.send(:set_order)
        }.to raise_error NoMethodError
      end
      it 'should set the current_user' do
        expect_any_instance_of(OrdersController).to receive(:purchase)
        controller.send(:set_order)
        expect(assigns(:order).user).to eq current_user
      end
    end
  end

  describe 'Test Resolution' do
    let(:valid_params) {
      {
        :id => nil,
        :token => 'EC-59R59009BF276314F',
        :PayerID => 'H7E8K2LT573UN',
        :order_total => 750.00
      }
    }
    before do
      @user = FactoryGirl.build(
        :user,
        email: 'h7e8k2lt573un@localhost'
      )
      @user.skip_confirmation_notification!
      @user.save!
      cart = FactoryGirl.build(:cart, user: @user)
      cart.save!
      cart.build_order.save
      valid_params[:id] = cart.order.id
      expect_any_instance_of(OrdersController).to receive(:current_cart).at_least(1).and_return(cart)
    end

    it ':confirm success' do
      VCR.use_cassette('resolution_success') do
        expect(@user.email).to eq 'h7e8k2lt573un@localhost'

        get :confirm, valid_params

        @user.reload
        expect(@user.email).to eq 'h7e8k2lt573un@localhost'
        expect(@user.unconfirmed_email).to eq 'daniel.crompton+paypal@gmail.com'
      end
    end

    it ':confirm failure' do
      VCR.use_cassette('resolution_failure') do
        expect(@user.email).to eq 'h7e8k2lt573un@localhost'

        get :confirm, valid_params

        @user.reload
        expect(@user.email).to eq 'h7e8k2lt573un@localhost'
        expect(@user.unconfirmed_email).to eq 'daniel.crompton+paypal@gmail.com'
      end
    end
  end
end
