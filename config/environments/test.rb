Oplerno::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  #config.middleware.use ::Rack::PerftoolsProfiler, default_printer: 'gif', bundler: true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = {:host => 'localhost:3000'}

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    #::GATEWAY = ActiveMerchant::Billing::BogusGateway.new
    ::GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(
        :login => "webhat-facilitator_api1.xs4all.nl",
        :password => "1388752803",
        :signature => ENV['PAYPAL_SIG'],
        # FIXME: Public Test URL here
        :ipn_notification_url => 'https://www.oplerno.com/orders/ipn',
        :return_url => 'https://www.oplerno.com/orders/confirm',
        :cancel_url => 'https://www.oplerno.com/orders/cancel',
    )
  end

  ::CANVAS_HOST = 'oplerno.test.instructure.com'
end
