class MailpreviewController < ApplicationController
	def show
		@user = User.last
		render "#{params[:mailer]}/#{params[:method]}", :layout => 'email'
	end
end
