ActiveAdmin.register OrderTransaction do
  actions :all, :except => [:destroy]
  index do
    column :success
    column 'Order Value' do |order_transaction|
      begin
        order_transaction.order.cart.total_price
      rescue => e
        p e
        order_transaction.amount/100
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
        val = order_transaction.params.decrypt Devise.secret_key
        "Unverified: #{JSON.parse(val)['order_description']}"
      end
    end
    column 'User' do |order_transaction|
      val = order_transaction.params.decrypt Devise.secret_key
      user = User.find_by_email JSON.parse(val)['payer']
      begin
        cart = order_transaction.order.cart
        user = User.find(cart.user_id)
        name = "#{user.display_name} (#{cart.user_id})"
        link_to name, [:admin, user] unless user.nil?
      rescue => e
        p e
        user = User.find_by_email JSON.parse(val)['payer']

        link_to user.email, [:admin, user] unless user.nil?
      end
    end
  end
end
