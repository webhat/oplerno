task :cron => :environment do
  puts "Pulling new Users From Canvas..."
  CanvasUsers.update_all
  CanvasCourses.update_all
  puts "done."
end
