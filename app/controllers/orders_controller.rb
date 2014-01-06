class OrdersController < InheritedResources::Base
  def create
    p params[:order]
    @order = current_cart.build_order(params[:order])
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

    if !details_response.success?
      @message = details_response.message
      render :action => 'error'
      return
    end

    @address = details_response.address
  end

  private

  def purchase
    setup_response = GATEWAY.setup_purchase(
        @order.price_in_cents,
        :ip => @order.ip,
        :return_url => url_for(:action => 'confirm', :only_path => false),
        :cancel_return_url => url_for(:action => 'index', :only_path => false),
        :email => @order.user.email,
        :allow_note => false,
        :allow_guest_checkout => true,
    )
    p setup_response
    redirect_to GATEWAY.redirect_url_for(setup_response.token)
    #transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
    #cart.update_attribute(:purchased_at, Time.now) if response.success?
    #response.success?
  end

  def current_cart
    cart_id = params[:order]['cart_id']

    Cart.find(cart_id)
  end
end
