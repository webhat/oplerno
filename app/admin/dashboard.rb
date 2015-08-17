ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel "New Courses (#{Course.count})" do
          table_for Course.order( 'created_at DESC' ).limit ( 10 ) do
            column do |course|
              link_to course.name, [:admin, course]
            end
          end
        end
      end
      column do
        panel "Recently Active Courses (#{Course.count})" do
          table_for Course.order( 'updated_at DESC' ).limit ( 10 ) do
            column do |course|
              link_to course.name, [:admin, course]
            end
          end
        end
      end
      column do
        panel "New Users (#{User.count})" do
          table_for User.where('email NOT like "%localhost"').order( 'created_at DESC' ).limit ( 10 ) do
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
        panel "Recently Active Users (#{User.count})" do
          table_for User.where('email NOT like "%localhost"').order( 'updated_at DESC' ).limit ( 10 ) do
            column do |user|
              link_to user.display_name.force_encoding('UTF-8'), [:admin, user]
            end
          end
        end
      end
      column do
        panel "Recently Active Teachers (#{Teacher.count})" do
          table_for Teacher.limit(10).order('last_sign_in_at DESC') do
            column do |teacher|
              #teacher.rank.ranking
            end
            column do |teacher|
              link_to teacher.display_name.force_encoding('UTF-8'), [:admin, User.find(teacher.id)]
            end
          end
        end
      end
    end
    columns do
      column do
        panel "Ranking Teachers (#{TeacherRanking.count})" do
          table_for TeacherRanking.limit(10).order('ranking DESC') do
            column &:ranking
            column do |rank|
              link_to rank.teacher.display_name.force_encoding('UTF-8'), [:admin, User.find(rank.teacher.id)]
            end
          end
        end
      end
      column do
        panel "Ranking Courses (#{CourseRanking.count})" do
          table_for CourseRanking.limit( 10).order( 'ranking DESC') do
            column &:ranking
            column do |rank|
              link_to rank.course.name.force_encoding('UTF-8'), [:admin, rank.course]
            end
          end
        end
      end
    end
    columns do
      column do
        panel "Popular Searches (#{Search.count})" do
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
        panel "Recent Searches (#{Search.count})" do
          table_for Search.limit( 10).order( 'created_at DESC') do
            column 'Term' do |search|
              search.term
            end
          end
        end
      end
      column do
        panel "Recent Orders (#{Order.count})" do
          ul do
            table_for Order.limit( 10).map do
              column do |order|
                link_to order.cart_id, [:admin, order]
              end
            end
          end
        end
      end
      column do
        panel "Recent Cart (#{Cart.count})" do
          ul do
            table_for Cart.limit( 10).map do
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
    section link_to PaperTrail::Version, [:admin, :versions] do
      table_for PaperTrail::Version.order('id desc').includes(:item).limit(10) do
        column 'ID' do |v|
          item = v.item_type.constantize.with_deleted.find(v.item_id)
          if v.item.nil?
            item.id
          else
            link_to item.id, [:admin, v.item]
          end
        end
        column 'Type' do |v| v.item_type.underscore.humanize end
        column 'Item' do |v|
          v.item_type.constantize.with_deleted.find(v.item_id).display_name.force_encoding('UTF-8')
        end
        column 'Modified at' do |v| v.created_at.to_s :long end
        column 'Admin' do |v|
          begin
            link_to "Admin: #{AdminUser.find(v.whodunnit).email}",
              [:admin, AdminUser.find(v.whodunnit)]
          rescue
            begin
              link_to "User: #{User.find(v.whodunnit).email}",
                [:admin, User.find(v.whodunnit)]
            rescue
              'Unknown User'
            end
          end
        end
      end
    end
  end # content
end
