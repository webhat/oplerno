# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
if Rails.env.test? || Rails.env.development?
  Oplerno::Application.config.secret_key_base = '671fed24ccf0f5b7efda4d2c2b9bfa55127e443d15513077a1e0b385c605935d8411a81a86a139afddecc6e706834052369ba810774fe45b1a83e5786e6af754'
  Oplerno::Application.config.secret_token = '930899dfc24638ce65428770e57af014f9e26d7087f1cfcd26be94e12a2d1823670fec7c835242194c08a11f086962563f93028f94bae44696bb075f17bc6767'
else
  Oplerno::Application.config.secret_key_base = ENV['OPLERNO_KEYBASE']
  Oplerno::Application.config.secret_token = ENV['OPLERNO_TOKEN']
end
