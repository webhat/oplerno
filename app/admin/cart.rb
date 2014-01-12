ActiveAdmin.register Cart do

  #menu :parent => "Admin"

  index do
    column :total_price
    column :purchased_at
    column :courses do |cart|
      table_for cart.courses do
        column do |course|
          link_to course.name, [ :admin, course ]
        end
      end
    end
    column 'User' do |cart|
      user = User.find(cart.user_id)
      "#{user.first_name} #{user.last_name} (#{cart.user_id})"
    end

        default_actions
  end

  filter :purchased_at
end                                   
