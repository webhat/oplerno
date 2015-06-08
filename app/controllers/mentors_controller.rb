class MentorsController < TeamsController
  before_filter :find_resource, only: [:show, :edit, :update]

  def show
    render 'teams/show'
  end

  private
  def find_resource
    @resource = Mentor.find( params[:id] )
  end
end
