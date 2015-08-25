# Handles #User objects.
class UsersController  < ApplicationController #< InheritedResources::Base #
  before_filter :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:show, :edit, :update, :destroy]

  # GET /users/1/edit
  def edit
    return unless current_user?
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    return unless current_user?

    respond_to do |format|
      if @user.update_attributes(user_params)
        if @user.email[-11..-1] == 'oplerno.com'
          format.html { redirect_to "/teachers/#{@user.id}", notice: "User was successfully updated. <span class='pull-right'>#{undo_link}</span>" }
        else
          format.html { redirect_to @user, notice: "User WAS successfully updated. <span class='pull-right'>#{undo_link}</span>" }
        end
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    return unless current_user?

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def whoami
    current_user
  end

  def undo_link
    unless @user.versions.scoped.last.nil?
      view_context.link_to("undo", revert_version_path(@user.versions.scoped.last), :method => :post)
    end
  end

  protected

  def current_user?
    unless @user.id == current_user.id
      redirect_to @user, alert: (I18n.t 'users.fail.user_record')
      return false
    end
    return true
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    unless params[:id].nil?
      @user = User.friendly.find(params[:id])
    else
      @user = User.friendly.find(current_user.id)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params[:user]
  end
end
