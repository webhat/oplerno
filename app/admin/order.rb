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
      user = User.find(cart.user_id)
      "#{user.first_name} #{user.last_name} (#{cart.user_id})"
    end
    default_actions
  end

  form do |f|
    f.inputs "Course Details" do
      f.input :cart, :collection => Cart.all.map(&:id)
      f.input :user, :collection => User.all.map { |x| ["#{x.first_name} #{x.last_name}", x.id] }
    end
    f.actions
  end
end                                   
