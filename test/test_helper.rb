ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/focus'
require 'minitest/reporters'
require 'minitest/autorun'
MiniTest::Reporters.use!


class ActiveSupport::TestCase
#  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all

  @@fixtures = {}

  def self.fixtures list
    [list].each do |fixture|
      @@fixtures[fixture.to_sym] ||= {}
      self.class_eval do
        # add a method name for this fixture type
        define_method(fixture.to_s) do |item|
          # FIXME: load and cache the YAML
          clazz = "#{fixture.to_s.classify}".constantize

          YAML::load_file("#{self.fixture_path}/#{fixture.to_s}.yml").each { |name, hash|
            @@fixtures[fixture.to_sym][name.to_sym] = clazz.new(hash)
          }


          @@fixtures[fixture.to_sym][item.to_sym]
        end
      end
    end
  end


  def self.all_fixtures
    yaml_files = Dir["#{self.fixture_path}/**/*.yml"].select { |f|
      fixtures File.basename(f, ".*")
    }
  end

  all_fixtures


  # Add more helper methods to be used by all tests here...
end
