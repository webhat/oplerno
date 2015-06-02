class TeamsController < ApplicationController
  def show
    @team = @resource = Team.find( params[:id] )
  end
end
