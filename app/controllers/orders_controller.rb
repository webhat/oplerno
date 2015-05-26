# Relies on #Cart and #OrderTransaction to process the #Order requests.
class OrdersController < InheritedResources::Base
  def create
    set_order
  end

  def confirm
    redirect_to :action => 'index' unless token_params

    details_response = GATEWAY.details_for(token_params)

    resolve_payment details_response
  end

  def paypal_ipn
    notify = Paypal::Notification.new(@request.raw_post)
    # TODO: resolve payer here
    if notify.acknowledge
      create_ot_transaction 'purchase', details_response if notify.complete?
    else
      logger.info(@request)
      create_ot_transaction 'error', details_response
    end
  end

  private

  def resolve_payment details_response
    ot = nil
    unless details_response.success?
      @message = details_response.message
      ot = create_transaction 'error', details_response
      flash[:alert] = @message
    else
      ot = create_transaction 'purchase', details_response
      courses_to_students
      flash[:notice] = (I18n.t 'orders.success')
    end
    update_email details_response.params['payer'], ot.order.cart.user
  end

  def update_email payer, user
    unless (user.email =~ /.*@localhost/).nil?
      user.email = payer
      user.save
      user.send_confirmation_instructions
    end unless user.nil?
  end

  def courses_to_students
    current_cart.courses_to_student
    current_user.cart = Cart.create!
    current_user.save
  end

  def create_transaction(action, details_response)
    transactions.create!(
      action: action,
      amount: price_in_cents,
      response: details_response
    )
  end

  def create_ot_transaction action, details_response
    OrderTransaction.create!(
      action: action,
      amount: price_in_cents,
      response: details_response
    )
  end

  def order
    current_cart.order
  end

  def price_in_cents
    order.price_in_cents
  end

  def transactions
    order.transactions
  end

  def token_params
    params[:token]
  end

  def set_order
    @order = current_cart.build_order(params[:order])

    @order.user = current_user
    @order.ip = request.remote_ip

    if @order.save
      purchase
    else
      render :action => 'new'
    end
  end

  def purchase
    setup_response = GATEWAY.setup_purchase(
      @order.price_in_cents, ip: @order.ip,
      return_url: url_for(controller: 'orders', id: @order.id, action: 'confirm', only_path: false),
      items: items_in_cart,
      cancel_return_url: url_for(controller: 'carts', action: 'index', only_path: false),
      ipn_notification_url: url_for(controller: 'orders', id: @order.id, action: 'paypal_ipn', only_path: false),
      email: current_user.email,
      allow_note: false, allow_guest_checkout: false,
      description: I18n.t('orders.description'),
    )

    redirect_to GATEWAY.redirect_url_for(setup_response.token)
  end

  def items_in_cart
    current_cart.courses.map do |course|
      {
        name: course.name,
        quanity: 1,
        description: Nokogiri::HTML(course.description).text[0..50],
        amount: course.price*100
      }
    end + [{name: 'Canvas Subscription', quantity: 1, description: '', amount: 0}]
  end

  def current_cart
    @cart ||= current_user.cart
  end

  private
  def all_courses
    current_cart.courses.map(&:name)
  end
end
