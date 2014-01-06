class OrdersController < InheritedResources::Base
  def create
    @order = current_cart.build_order(params[:order])
    @order.user = current_user
    @order.ip = request.remote_ip
    if @order.save
      purchase
    else
      render :action => 'new'
    end
  end

  def confirm
    redirect_to :action => 'index' unless params[:token]

    details_response = GATEWAY.details_for(params[:token])

    current_cart.order.transactions.create!(:action => "purchase", :amount => current_cart.order.price_in_cents, :response => details_response)

    if !details_response.success?
      @message = details_response.message
      render :action => 'error'
      return
    end

    p details_response
  end

  private

  def purchase
    setup_response = GATEWAY.setup_purchase(
        @order.price_in_cents,
        :ip => @order.ip,
        :return_url => url_for(:action => 'confirm', :only_path => false),
        :cancel_return_url => url_for(:controller => 'carts', :action => 'index', :only_path => false),
        :email => current_user.email,
        :description => 'Course(s) with Oplerno LLC.',
        :allow_note => false,
        :allow_guest_checkout => false,
    )

    redirect_to GATEWAY.redirect_url_for(setup_response.token)
  end

  def current_cart
    Cart.find_by_user_id(current_user.id)
  end
end
