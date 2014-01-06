require 'spec_helper'

describe CartsController do
  login_user

  let(:valid_attributes) { { user_id: "1" } }

  let(:valid_course) { {name: 'The Orange Theme'} }

  before(:each) do
    course = Course.create! valid_course
    session[:course_id] = course.id
  end

  describe "GET index" do
    it "assigns all carts as @carts" do
      cart = Cart.create! valid_attributes
      get :index, {}
      assigns(:carts).should eq([cart])
    end
  end

  describe "GET show" do
    it "assigns the requested cart as @cart" do
      cart = Cart.create! valid_attributes
      get :show, {:id => cart.to_param}
      assigns(:cart).should eq(cart)
    end
  end

  describe "GET new" do
    it "assigns a new cart as @cart" do
      get :new, {}
      assigns(:cart).should be_a_new(Cart)
    end
  end

  describe "GET edit" do
    it "assigns the requested cart as @cart" do
      cart = Cart.create! valid_attributes
      get :edit, {:id => cart.to_param}
      assigns(:cart).should eq(cart)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Cart" do
        expect {
          post :create, {:cart => valid_attributes}
        }.to change(Cart, :count).by(1)
      end

      it "assigns a newly created cart as @cart" do
        post :create, {:cart => valid_attributes}
        assigns(:cart).should be_a(Cart)
        assigns(:cart).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cart as @cart" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cart.any_instance.stub(:save).and_return(false)
        post :create, {:cart => {}}
        assigns(:cart).should_not be_a_new(Cart)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested cart" do
        cart = Cart.create! valid_attributes
        # Assuming there are no other carts in the database, this
        # specifies that the Cart created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Cart.any_instance.should_receive(:update_attributes).with({"these" => "params"})
        put :update, {:id => cart.to_param, :cart => {"these" => "params"}}
      end

      it "assigns the requested cart as @cart" do
        cart = Cart.create! valid_attributes
        put :update, {:id => cart.to_param, :cart => valid_attributes}
        assigns(:cart).should eq(cart)
      end

      it "redirects to the cart" do
        cart = Cart.create! valid_attributes
        put :update, {:id => cart.to_param, :cart => valid_attributes}
        response.should redirect_to(cart)
      end
    end

    describe "with invalid params" do
      it "assigns the cart as @cart" do
        cart = Cart.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Cart.any_instance.stub(:save).and_return(false)
        put :update, {:id => cart.to_param, :cart => {}}
        assigns(:cart).should eq(cart)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cart" do
      cart = Cart.create! valid_attributes
      p Cart.count
      p Cart.all
      expect {
        delete :destroy, {:id => cart.to_param}
        p Cart.count
        p Cart.all
      }.to change(Cart, :count).by(-1)
    end

    it "redirects to the carts list" do
      cart = Cart.create! valid_attributes
      delete :destroy, {:id => cart.to_param}
      response.should redirect_to(courses_url)
    end
  end

end
