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
        format.html { redirect_to instance_variable_get("@#{model}"), notice: (I18n.t "#{model}s.success.update") + " <span class='pull-right'>#{undo_link model}</span>"  }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: instance_variable_get("@#{model}").errors, status: :unprocessable_entity }
      end
    end
  end

  def undo_link model
    unless instance_variable_get("@#{model}").versions.last.nil?
      view_context.link_to("undo", revert_version_path(instance_variable_get("@#{model}").versions.last), :method => :post)
    end
  end

  def create_and_signin_user
    user = create_user
    sign_in :user, user
    user
  end

  def create_user
    user = User.new
    user.password = generated_code
    user.password_confirmation = generated_code
    user.email = "#{generated_code}@localhost"
    user.skip_confirmation!
    user.save!
    user
  end

  def generated_code
    token ||= Digest::SHA256.hexdigest(Time.now.to_s)[0..10]
  end
end
