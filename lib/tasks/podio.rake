namespace :podio do
	task :users => :environment do
		#puts 'Password: '
		#password = STDIN.noecho(&:gets).strip
		PodioCrm.authenticate_with_credentials
		limit = 40
		[0,1,2,3,4,5,6,7,8,9,10].each do |page|
			items = Podio::Item.find_all(8822781, limit: limit, offset: page*limit)
			items.all.each do |e|
				pt = PodioTeacher.new
				e.attributes[:fields].each do |f|
					name = f['label'].parameterize.underscore
					field_id = f['field_id']
					begin
						pt.send("#{name}=", f['values'][0]['value'])
					rescue
						puts "Missing: #{name}:#{field_id}"
					end
					if field_id == 68472124 
						pt.faculty_oplerno_email = ActionView::Base.full_sanitizer.sanitize f['values'][0]['value'] 
					end 
				end
				if pt.faculty_oplerno_email
					pt.teacher = Teacher.find_by_email pt.faculty_oplerno_email.strip
				end
				pt.save
			end
		end
	end
end
