namespace :podio do
	task :users => :environment do
		puts 'Password: '
		password = STDIN.noecho(&:gets).strip
		Podio.client.authenticate_with_credentials('daniel.crompton@gmail.com', password)
		limit = 40
		[0,1,2,3,4,5,6,7,8,9,10].each do |page|
			items = Podio::Item.find_all(8822781, limit: limit, offset: page*limit)
			YAML.dump items.fields
			exit
			items.all.each do |e|
				e.attributes[:fields].each do |f|
					#puts YAML::dump f
					if f['field_id'] == 68472124 
						email = ActionView::Base.full_sanitizer.sanitize f['values'][0]['value'] 
						puts "#{e.attributes[:app_item_id]},#{email}"
					end 
				end
				exit
			end
		end
	end
end
