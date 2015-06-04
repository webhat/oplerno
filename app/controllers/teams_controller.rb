class TeamsController < ApplicationController
  before_filter :find_resource, only: [:show, :edit]

  def update
    @resource = Team.find( params[:id] )
    @resource.update_attributes resource_params
    redirect_to @resource
  end

  private
  def find_resource
    @resource = Team.find( params[:id] )
  end

  def resource_params
    params[:resource]
  end
end
