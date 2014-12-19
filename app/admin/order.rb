ActiveAdmin.register Order do
  actions :all, :except => [:destroy]
  index do
    column 'Order ID' do |order|
      order.id
    end
    column 'Order Value' do |order|
      begin
        order.cart.total_price
      rescue
        'NA'
      end
    end
    column :courses do |order|
      begin
        table_for order.cart.courses do
          column do |course|
            link_to course.name, [:admin, course]
          end
        end
      rescue
        'NA'
      end
    end
    column 'User' do |cart|
      begin
        user = User.find(cart.user_id)
        link_to "#{user.encrypted_first_name} #{user.encrypted_last_name} (#{cart.user_id})", [:admin, user]
      rescue
        puts $!.inspect, $@
        "*encrypted* (#{cart.user_id})"
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
