class MailpreviewController < ApplicationController
  before_filter :authenticate_admin_user!

	def show
		@user = User.last
		@message = {email: @user.email}
		render "#{params[:mailer]}/#{params[:method]}", :layout => 'email'
	end
end
