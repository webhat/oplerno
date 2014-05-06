class WelcomeController < ApplicationController
	helper_method :resource, :resource_name, :resource_class, :devise_mapping

	def index
		render 'welcome/index', layout: false
	end

	def resource
		User.new
	end

	def resource_name
		:user
	end

	def resource_class
		User
	end

	def devise_mapping
		Devise.mappings[resource_name]
	end
end
