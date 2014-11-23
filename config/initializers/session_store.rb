# Be sure to restart your server when you modify this file.

#Oplerno::Application.config.session_store :cookie_store, key: '_oplerno_session'
Oplerno::Application.config.session_store :redis_store, :servers => "#{ENV['PAPERCLIP_REDIS']}/10"
