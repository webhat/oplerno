ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1, :label => proc { I18n.t("active_admin.dashboard") }

  content :title => proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "New Courses (#{Course.all.count})" do
          table_for Course.all(limit: 10, order: 'created_at DESC') do
            column do |course|
              link_to course.name, [:admin, course]
            end
          end
        end
      end
      column do
        panel "Recently Active Courses (#{Course.all.count})" do
          table_for Course.all(limit: 10, order: 'updated_at DESC') do
            column do |course|
              link_to course.name, [:admin, course]
            end
          end
        end
      end
      column do
        panel "New Users (#{User.all.count})" do
          table_for User.all(limit: 10, order: 'created_at DESC') do
            column do |user|
							link_to user.display_name.force_encoding('UTF-8'), [:admin, user]
            end
            column do |user|
							link_to user.email, [:admin, user]
            end
          end
        end
      end
      column do
        panel "Recently Active Users (#{User.all.count})" do
          table_for User.all(limit: 10, order: 'last_sign_in_at DESC') do
            column do |user|
							link_to user.display_name.force_encoding('UTF-8'), [:admin, user]
            end
          end
        end
      end
      column do
        panel "Recently Active Teachers (#{Teacher.all.count})" do
          table_for Teacher.all(limit: 10, order: 'last_sign_in_at DESC') do
            column do |teacher|
							teacher.rank.ranking
						end
            column do |teacher|
							link_to teacher.display_name.force_encoding('UTF-8'), [:admin, User::find(teacher.id)]
            end
          end
        end
      end
		end
    columns do
      column do
        panel "Ranking Teachers (#{TeacherRanking.all.count})" do
          table_for TeacherRanking.all(limit: 10, order: 'ranking DESC') do
            column do |rank|
							rank.ranking
						end
            column do |rank|
							link_to rank.teacher.display_name.force_encoding('UTF-8'), [:admin, User::find(rank.teacher.id)]
            end
          end
        end
      end
      column do
        panel "Ranking Courses (#{CourseRanking.all.count})" do
          table_for CourseRanking.all(limit: 10, order: 'ranking DESC') do
            column do |rank|
							rank.ranking
						end
            column do |rank|
							link_to rank.course.name.force_encoding('UTF-8'), [:admin, rank.course]
            end
          end
        end
      end
    end
    columns do
      column do
        panel "Popular Searches (#{Search.all.count})" do
					table_for Search.select('term, count(id) as count_id').group('term').limit(10).order('count_id desc') do
            column 'Term' do |search|
							search.term
            end
            column 'Number' do |search|
							search.count_id
            end
          end
        end
      end
      column do
        panel "Recent Searches (#{Search.all.count})" do
          table_for Search.all(limit: 10, order: 'created_at DESC') do
            column 'Term' do |search|
							search.term
            end
          end
        end
      end
      column do
        panel "Recent Orders (#{Order.all.count})" do
          ul do
            table_for Order.all(limit: 10).map do
              column do |order|
                link_to order.cart_id, [:admin, order]
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
								begin
									link_to cart.total_price, [:admin, cart]
								rescue
									'?'
								end
              end
            end
          end
        end
      end
		end
   # div :class => "blank_slate_container", :id => "dashboard_default_message" do
   #   span :class => "blank_slate" do
   #     span I18n.t("active_admin.dashboard_welcome.welcome")
   #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
   #   end
   # end

		section link_to PaperTrail::Version, [:admin, :versions] do
			table_for PaperTrail::Version.order('id desc').limit(10) do # Use PaperTrail::Version if this throws an error
				column "ID" do |v| link_to v.item.id, [:admin, v.item] end # Uncomment to display as link
				column "Item" do |v| v.item.display_name.force_encoding('UTF-8') end
				column "Type" do |v| v.item_type.underscore.humanize end
				column "Modified at" do |v| v.created_at.to_s :long end
				column "Admin" do |v|
					begin
						link_to "Admin: #{AdminUser.find(v.whodunnit).email}", [:admin, AdminUser.find(v.whodunnit)]
					rescue
						begin
						link_to "User: #{User.find(v.whodunnit).email}", [:admin, User.find(v.whodunnit)]
						rescue
							'Unknown User'
						end
					end
				end
			end
		end
  end # content
end
