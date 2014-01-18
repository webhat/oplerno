ActiveAdmin.register Order do
  index do
    column 'Order Value' do |order|
      Cart.find(order.cart_id).total_price
    end
    column :courses do |order|
      table_for order.cart.courses do
        column do |course|
          link_to course.name, [:admin, course]
        end
      end
    end
    column 'User' do |cart|
      begin
        user = User.find(cart.user_id)
        "#{user.encrypted_first_name} #{user.encrypted_last_name} (#{cart.user_id})"
      rescue
        puts $!.inspect, $@
        '*encrypted*'
      end
    end
    default_actions
  end

  form do |f|
    f.inputs "Course Details" do
      f.input :cart, :collection => Cart.all.map(&:id)
      f.input :user, :collection => User.all.map { |x| ["#{x.encrypted_first_name} #{x.encrypted_last_name}", x.id] }
    end
    f.actions
  end
end                                   
