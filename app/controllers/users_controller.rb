# Handles #User objects.
class UsersController  < ApplicationController #< InheritedResources::Base #
  before_filter :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:show, :edit, :update, :destroy]

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
	#
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
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params[:user]
  end
end
