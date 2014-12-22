module OrdersHelper
  def current_cart
    #current_user.cart
    @cart
  end
  def current_order
    current_cart.order
  end
end
