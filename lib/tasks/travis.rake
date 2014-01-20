require 'coveralls/rake/task'
Coveralls::RakeTask.new
task :travis do
  # TODO: Add "rake jasmine:ci"
  ["rspec spec/", "rake cucumber"].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end
task :travis => [:spec, :features, 'coveralls:push']