require File.expand_path('../config/application', __FILE__)

require 'reek/rake/task'

Reek::Rake::Task.new do |t|
  t.fail_on_error = false
end

Oplerno::Application.load_tasks
