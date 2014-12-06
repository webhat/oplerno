ENV['RAILS_ENV'] ||= 'test'
#require 'perf_tools'

require File.expand_path('../../config/environment', __FILE__)

require 'ruby-saml'
require 'rspec/rails'
require 'capybara/rspec'
require 'rspec/autorun'
require 'cadre/rspec'

require 'factory_girl_rails'
require 'faker'
require 'cucumber'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
	# ## Mock Framework
	#
	# If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
	#
	# config.mock_with :mocha
	# config.mock_with :flexmock
	# config.mock_with :rr

	# config.infer_spec_type_from_file_location!

	# Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
	config.fixture_path = "#{::Rails.root}/spec/fixtures"

	# If you're not using ActiveRecord, or you'd prefer not to run each of your
	# examples within a transaction, remove the following line or assign false
	# instead of true.
	config.use_transactional_fixtures = false

	config.before :each do
		if Capybara.current_driver == :rack_test
			DatabaseCleaner.strategy = :transaction
		else
			DatabaseCleaner.strategy = :truncation
		end
		DatabaseCleaner.start

		ActiveRecord::Base.observers.disable :all
	end

	config.after do
		DatabaseCleaner.clean
	end


	# If true, the base class of anonymous controllers will be inferred
	# automatically. This will be the default behavior in future versions of
	# rspec-rails.
	config.infer_base_class_for_anonymous_controllers = false

	# Run specs in random order to surface order dependencies. If you find an
	# order dependency and want to debug it, you can fix the order by providing
	# the seed, which is printed after each run.
	#     --seed 1234
	config.order = 'random'

	config.include Devise::TestHelpers, :type => :controller
	config.extend ControllerMacros, :type => :controller

=begin
	config.before :suite do
		PerfTools::CpuProfiler.start('/tmp/rspec_profile')
	end

	config.after :suite do
		PerfTools::CpuProfiler.stop
	end
=end
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  if config.formatters.empty?
    config.add_formatter(:progress)
    #but do consider:
    #config.add_formatter(Cadre::RSpec::TrueFeelingsFormatter)
  end
  config.add_formatter(Cadre::RSpec::NotifyOnCompleteFormatter)
  config.add_formatter(Cadre::RSpec::QuickfixFormatter)
end
