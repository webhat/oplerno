class TeamsController < ApplicationController
  before_filter :find_resource, only: [:show, :edit, :update]
  before_filter :authenticate_user!, only: [:update]

  helper_method :member_can_edit?

  def update
    respond_to do |format|
        format.json {
          if member_can_edit?
            @resource.update_attributes resource_params
            render json: resource_params, status: 200
          else
            render json: {}, status: 403
          end
        }
    end
  end

  protected
  def resource_params
    params[:resource]
  end

  def member_can_edit?
    !@resource.mentors.select{|u| u.id == current_user.id }.empty?
  end

  private
  def find_resource
    @resource = Team.find(params[:id] )
  end
end
