class SubjectsController < ApplicationController
  def index
    @subjects = Subject.includes(:courses)
  end

  def show
    @subject = Subject.includes(:courses).find(params[:id])
  end
end
