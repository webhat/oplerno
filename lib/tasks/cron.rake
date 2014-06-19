
namespace :cron do
	task :users => :environment do
		puts 'Pulling new Users From Canvas...'
		CanvasUsers.update_all
		puts 'done.'
	end
	task :courses => :environment do
		puts 'Pulling new Courses From Canvas...'
		CanvasCourses.update_all
		puts 'done.'
	end
end
