ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc { I18n.t("active_admin.dashboard") }

  content :title => proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Orders (#{Order.all.count})" do
          ul do
            table_for Order.all(limit: 10).map do
              column do |order|
                link_to order.cart_id, [:admin, order.cart]
              end
            end
          end
        end
      end

      column do
        panel "Recent Cart (#{Cart.all.count})" do
          ul do
            table_for Cart.all(limit: 10).map do
              column do |cart|
                link_to cart.total_price, [:admin, cart]
              end
            end
          end
        end
      end

      column do
        panel "Recent Courses (#{Course.all.count})" do
          table_for Course.all(limit: 10) do
            column do |course|
              link_to course.name, [:admin, course]
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

  end # content
end
