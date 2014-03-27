# {include:UserController}
# See #UserController
class TeachersController < UsersController
  before_filter :set_teacher, only: [:show, :edit]
  before_filter :authenticate_user!, only: [:edit]

  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
    redirect_to '/' and return if @teacher.nil?
    respond_to do |format|
      format.html { render action: 'show' }
      format.json { render json: [current_user], status: :ok }
    end
  end

  # GET /teachers/1/edit
  def edit
    redirect_to edit_user_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def teacher_params
    params[:teacher]
  end

  def user_exists
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: 'The teacher already registered.' }
      format.json { render json: @teacher.errors, status: :unprocessable_entity }
    end
  end
end
