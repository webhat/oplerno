class OrdersController < InheritedResources::Base
  def create
    @order = current_cart.build_order(params[:order])
    @order.ip_address = request.remote_ip
    if @order.save
      if @order.purchase
        render :action => "success"
      else
        render :action => "failure"
      end
    else
      render :action => 'new'
    end
  end

  private

  def current_cart
    cart_id = params[:order]['cart_id']

    Cart.find(cart_id)
  end
end
