ActiveAdmin.register OrderTransaction do
	actions :all, :except => [:destroy]
  index do
    column :success
    column 'Order Value' do |order_transaction|
			begin
				order_transaction.order.cart.total_price
			rescue => e
				p e
				'?'
			end
    end
    column :message
    column :courses do |order_transaction|
			begin
				table_for order_transaction.order.cart.courses do
					column do |course|
						link_to course.name, [:admin, course]
					end
				end
			rescue => e
				p e
				'?'
			end
    end
    column 'User' do |order_transaction|
			begin
      cart = order_transaction.order.cart
      user = User.find(cart.user_id)
      "#{user.encrypted_first_name} #{user.encrypted_last_name} (#{cart.user_id})"
			rescue => e
				p e
				'?'
			end
    end
  end
end
