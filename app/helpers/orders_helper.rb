module OrdersHelper
	def current_cart
		current_user.cart
	end
	def current_order
		current_cart.order
	end
end
