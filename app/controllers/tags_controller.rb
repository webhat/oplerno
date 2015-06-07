class TagsController < ApplicationController
  def show
    @resource = Tag.includes(:mentors, :teams).find(params[:id])
  end
end
