class TeachersController < ApplicationController
  before_filter :set_teacher, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:edit, :update, :destroy]

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
      format.jpeg {
        send_data(Base64.decode64(@teacher.binary_data), :type => @teacher.content_type, :filename => @teacher.filename,
                  :disposition => 'inline') unless @teacher.binary_data.nil?
      }
    end
  end

  # GET /teachers/new
  def new
    sign_out current_user
    @teacher = Teacher.new
  end

  # GET /teachers/1/edit
  def edit
    p @teacher.key
    p current_user.key
    unless @teacher.key == current_user.key
      redirect_to current_user, notice: 'You can only edit your own user record'
      return
    end
  end

  # POST /teachers
  # POST /teachers.json
  def create
    user_exists and return unless Teacher.find_by_email(teacher_params[:email]).nil?
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, notice: 'Teacher was successfully created.' }
        format.json { render action: 'show', status: :created, location: @teacher }
      else
        format.html { render action: 'new' }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    unless @teacher.key == current_user.key
      redirect_to current_user, notice: 'You can only edit your own user record'
      return
    end

    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url }
      format.json { head :no_content }
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

  def user_exists
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: 'The teacher already registered.' }
      format.json { render json: @teacher.errors, status: :unprocessable_entity }
    end
  end
end
