ActiveAdmin.register_page 'Versions' do
  content :title => proc { I18n.t('active_admin.versions') } do
    section 'Recently updated content' do
      table_for PaperTrail::Version.order('id desc').limit(250) do
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
            link_to "Admin: #{AdminUser.find(v.whodunnit).email}", [:admin, AdminUser.find(v.whodunnit)]
          rescue
            begin
              link_to "User: #{User.find(v.whodunnit).email}", [:admin, User.find(v.whodunnit)]
            rescue
              'Unknown User'
            end
          end
        end
        column 'Deleted' do |v| v.item.nil? end
      end
    end
  end # content
end

