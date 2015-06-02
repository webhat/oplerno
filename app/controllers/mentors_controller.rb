class MentorsController < ApplicationController
  def show
    @resource = Mentor.find( params[:id] )
    render 'teams/show'
  end
end
