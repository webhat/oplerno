ActiveAdmin.register_page "Versions" do
  content :title => proc { I18n.t("active_admin.versions") } do
		section "Recently updated content" do
			table_for PaperTrail::Version.order('id desc').limit(100) do # Use PaperTrail::Version if this throws an error
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

