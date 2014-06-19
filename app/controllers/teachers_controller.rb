# {include:UserController}
# See #UserController
class TeachersController < UsersController
  before_filter :set_teacher, only: [:show, :edit, :contact]
  before_filter :authenticate_user!, only: [:edit]

  # GET /teachers
  # GET /teachers.json
  def index
		@teachers = Teacher.where("email like ?", "%oplerno.com%")
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

  # POST /teachers/1/contact
	def contact
		render nil, status: 500 and return unless params[:format] == 'json'
		ContactTeacher.student_mail(valid_question).deliver
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
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

	def valid_question
		unless question_params[:course_id] == ""
			course = Course.find(question_params[:course_id])
		end
		{
			from: "#{params[:question][:from]} #{question_params[:email]}",
			email: @teacher.email,
			course: course,
			question: question_params[:question]
		}
	end

	def question_params
		params[:question]
	end

  def user_exists
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: 'The teacher already registered.' }
      format.json { render json: @teacher.errors, status: :unprocessable_entity }
    end
  end
end
