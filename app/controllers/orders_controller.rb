# Relies on #Cart and #OrderTransaction to process the #Order requests.
class OrdersController < InheritedResources::Base
	def create
		set_order
	end

	def confirm
		redirect_to :action => 'index' unless token_params

		details_response = GATEWAY.details_for(token_params)

		unless details_response.success?
			@message = details_response.message
			transactions.create!(:action => "error", :amount => price_in_cents, :response => details_response)
			flash[:alert] = @message
		else
			transactions.create!(:action => "purchase", :amount => price_in_cents, :response => details_response)
			current_cart.courses_to_student
			current_user.cart = Cart.create!
			current_user.save
			flash[:notice] = (I18n.t 'orders.success')
		end
	end

	def paypal_ipn
		notify = Paypal::Notification.new(@request.raw_post)
		if notify.acknowledge
			OrderTransaction.create!(:action => "purchase", :amount => price_in_cents, :response => details_response) if notify.complete?
		else
			logger.info(@request)
			OrderTransaction.create!(:action => "error", :amount => price_in_cents, :response => details_response)
		end
	end

	private

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
			@order.price_in_cents,
			:ip => @order.ip,
			:return_url => url_for(controller: 'orders', action: 'confirm', only_path: false),
			:cancel_return_url => url_for(:controller => 'carts', :action => 'index', :only_path => false),
			:email => current_user.email,
			:description => (I18n.t 'payments.description', { courses: all_courses}),
			:allow_note => false,
			:allow_guest_checkout => false,
		)

		redirect_to GATEWAY.redirect_url_for(setup_response.token)
	end

	def current_cart
		@cart ||= current_user.cart
	end

	private
	def all_courses
		current_cart.courses.map(&:name)
	end
end
