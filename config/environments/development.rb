Oplerno::Application.configure do
  # Settings specified here will take precedence over those in
  # config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = false
  config.action_mailer.default_url_options = {:host => 'enroll.oplerno.com'}

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.eager_load = false

  config.after_initialize do
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      address: 'smtp.mandrillapp.com',
      port: 587,
      domain: 'oplerno.com',
      user_name: 'webmaster@oplerno.com',
      password: ENV['MAIL_PASSWORD'],
      authentication: 'plain',
      enable_starttls_auto: true,
      openssl_verify_mode: 'none'
    }

    ActiveMerchant::Billing::Base.mode = :production
    ::GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(
      :login      => ENV['PAYPAL_USER'],
      :password   => ENV['PAYPAL_PASS'],
      :signature  => ENV['PAYPAL_SIG'],
      :ipn_notification_url => 'https://enroll.oplerno.com/orders/ipn',
      :return_url           => 'https://enroll.oplerno.com/orders/confirm',
      :cancel_url           => 'https://enroll.oplerno.com/orders/cancel',
    )
  end

  ::CANVAS_HOST = 'oplerno.test.instructure.com'

  Bullet.enable = false
  Bullet.alert = true
  Bullet.bullet_logger = true
  Bullet.console = true
  Bullet.rails_logger = true
  Bullet.bugsnag = true
  Bullet.airbrake = true
  Bullet.add_footer = true
  Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
end
