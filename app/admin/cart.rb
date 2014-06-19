ActiveAdmin.register Cart do
	actions :all, :except => [:destroy]

  #menu :parent => "Admin"

  index do
    column :total_price
    column :purchased_at
    column :courses do |cart|
      table_for cart.courses do
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
     #   puts $!.inspect, $@
      end
    end

    default_actions
  end

  filter :purchased_at
end
