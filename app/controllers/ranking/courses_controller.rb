# CourseController feeds the Ranking Angular app as you change
# your #Teacher or #Course profile
class Ranking::CoursesController < ApplicationController
  before_filter :set_course, only: [
    :show,
    :update
  ]
  before_filter :authenticate_user!, only: [:show, :update]

  # Show a #Course or #Teacher ranking
  # GET /ranking/courses/1
  # GET /ranking/courses/1.json
  def show
    respond_to do |format|
      format.html {
        redirect_to '/'
      }
      format.json {
        render json: [rank: @course.rank.ranking]
      }
    end
  end

  def update
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end
end
