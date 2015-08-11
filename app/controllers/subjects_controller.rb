class SubjectsController < ApplicationController
  def index
    @subjects = Subject.includes(:courses).all
  end

  def show
    @subject = Subject.includes(:courses).find(params[:id])
  end
end
