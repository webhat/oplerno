class MentorsController < TeamsController
  before_filter :find_resource, only: [:show, :edit, :update]

  def create
    respond_to do |format|
        format.json {
          unless mentor_params[:email].nil?
            mentor = Mentor.find(create_and_signin_user.id)
            mentor.update_attributes mentor_params
            mentor.save
            render json: mentor_params, status: 200
          else
            render json: {}, status: 403
          end
        }
    end
  end

  def show
    render 'teams/show'
  end

  def signup
    if params[:welcome] == Setting.get_key('mentor_signup', '').value
    else
      redirect_to '/'
    end
  end

  private
  def find_resource
    @resource = Mentor.find( params[:id] )
  end

  def mentor_params
    params[:mentor]
  end
end
