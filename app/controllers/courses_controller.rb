# If this were a shop #Course would be the product
class CoursesController < ApplicationController
  before_filter :set_course, only: [:show, :edit, :update, :destroy, :image_picker]
  before_filter :authenticate_user!, except: [:show, :index]

  helper_method :add_course_to_cart, :logged_in?

  # GET /courses
  # GET /courses.json
  def index
    respond_to do |format|
      format.html {
        @courses = Course.order(:name).where(:hidden => false).page params[:page]
        @courses_underdev = Course.order(:name).where(:hidden => true).page params[:page]
      }
      format.json {
        @courses = Course.all
        render json: @courses
      }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    respond_to do |format|
      format.html { render action: 'show' }
      format.json { render json: [@course], status: :ok }
      format.jpeg {
        if @course.avatar.nil?
          redirect_to '/assets/course.jpeg'
        end
      }
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/me
  # My courses
  def me
    @courses = current_user.courses
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.teacher = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: (I18n.t 'courses.success.create') }
        format.json { render action: 'show', status: :created, location: @course }
        current_user.courses << @course
        current_user.save
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /courses/1/edit
  def edit
    return unless current_user?
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    return unless current_user?

    update_model :course, course_params
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    return unless current_user?

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def image_picker
    return unless current_user?

    avatar = Course.find(params['image-picker']).avatar
    p "#{url_prefix request}#{avatar.url(:medium)}"
    @course.avatar = avatar
    @course.save
    render layout: false
  end

  def add_course_to_cart(course)
    session[:course_id] = course.id
    '/carts/'
  end

  protected

  def current_user?
    unless @course.teacher.to_i == current_user.id
      redirect_to course_url, alert: (I18n.t 'courses.fail.own_course')
      return false
    end
    return true
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params[:course]
  end
end
