class MailpreviewController < ApplicationController
	def show
		@user = User.last
		@message = {email: @user.email}
		render "#{params[:mailer]}/#{params[:method]}", :layout => 'email'
	end
end
