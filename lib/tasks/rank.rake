namespace :rank do
	task :teachers => :environment do
		TeacherRanking.all.each do |t| t.rank; t.save; end
	end
	task :courses => :environment do
		Course.all.each do |t| t.save; t.rank.rank ; t.save end
	end
end
