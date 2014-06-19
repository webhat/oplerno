namespace :search do
	task :courses => :environment do
		puts 'Indexing Courses for Search'
		Course.reindex
		puts 'done.'
	end
end
