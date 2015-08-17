class TagsController < ApplicationController
  before_filter :set_tag, only: [:update, :destroy]

  def index
    @mentor = Mentor.includes(:tags).find(mentor_id) if mentor_id 
    render json: @mentor.tags.map(&:clean_tag), status: :ok
  end

  def show
    @resource = Tag.includes(:mentors, :teams).friendly.find(params[:id])
  end

  def update
    @tag.update_attributes tag_params
    render json: tag_params, status: :ok
  end

  def create
    @tag = Tag.create! tag_params 
    @tag.mentors << Mentor.find(mentor_id) if mentor_id 
    render json: @tag.clean_tag, status: :ok
  end

  def destroy
    @tag.destroy
    render json: tag_params, status: :ok
  end

  private
  def tag_params
    params[:tag]
  end

  def set_tag
    @tag = Tag.friendly.find(params[:id])
  end

  def mentor_id
    params[:mentor_id]
  end
end
