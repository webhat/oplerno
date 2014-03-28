class WelcomeController < ApplicationController
	def index
		render 'welcome/index', layout: false
	end
end
