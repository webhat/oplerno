# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

require 'coveralls/rake/task'
Coveralls::RakeTask.new
task :test_with_coveralls => [:spec, :features, 'coveralls:push']

#require 'reek/rake/task'

#Reek::Rake::Task.new do |t|
#  t.fail_on_error = false
#end

Oplerno::Application.load_tasks
