class CartsController < InheritedResources::Base
  before_filter :set_cart, only: [:create, :show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def create
    @cart.user_id = current_user.id
    @cart.courses << Course.find(session[:course_id])
    @cart.save

    redirect_to courses_url
  end

  def destroy
    @cart.courses.clear
    @cart.destroy

    redirect_to courses_url
  end

  private

  def set_cart
    unless current_user.cart.nil?
      @cart = Cart.find(current_user.cart)
    else
      @cart = Cart.create!
    end
  end

  def cart_params
    params[:cart]
  end
end
