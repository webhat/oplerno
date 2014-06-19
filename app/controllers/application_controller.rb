class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers
  protect_from_forgery with: :exception
	include ApplicationHelper

	def user_for_paper_trail
		admin_user_signed_in? ? current_admin_user : current_user
	end

	def update_model model, params
		respond_to do |format|
			if instance_variable_get("@#{model}").update_attributes(params)
				format.html { redirect_to instance_variable_get("@#{model}"), notice: (I18n.t "#{model}s.success.update") }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: instance_variable_get("@#{model}").errors, status: :unprocessable_entity }
			end
		end
	end
end
