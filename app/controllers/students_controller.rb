# {include:UserController}
# See #UserController
class StudentsController < UsersController
  before_filter :set_student, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: (I18n.t 'students.success.create') }
        format.json { render action: 'show', status: :created, location: @student }
      else
        format.html { render action: 'new' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    return unless current_user?

    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  # GET /student/1/edit
  def edit
    return unless current_user?
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    return unless current_user?

    respond_to do |format|
      if @student.update_attributes(student_params)
        format.html { redirect_to @student, notice: (I18n.t 'students.success.update') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def current_user?
    unless @student.id == current_user.id
      redirect_to student_url, alert: (I18n.t 'users.fail.user_record')
      return false
    end
    return true
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params[:student]
  end
end
