class CartsController < InheritedResources::Base
  before_filter :set_cart, only: [:create, :show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  helper_method :remove_course_from_cart_url, :remove_course_from_cart, :logged_in?

  def create
    @cart.user_id = current_user.id
    course = Course.find(session[:course_id])
    if course.price.to_i > 0
      @cart.courses << Course.find(session[:course_id])
    else
      flash[:alert] = (I18n.t 'courses.fail.inactive')
    end
    @cart.save

    session[:course_id] = nil
    redirect_to courses_url
  end

  def show
    respond_to do |format|
      format.json { render json: @cart.courses, status: :ok }
      format.html { render action: 'show' }
    end
  end

  def destroy
    @cart.courses.clear
    @cart.destroy

    redirect_to courses_url
  end

  def remove_course_from_cart_url(course)
    "/carts/#{Cart.find_by_user_id(current_user.id).id}/#{course.id}"
  end

  def remove_course_from_cart
    @cart = Cart.find(params[:cart])
    @cart.courses.delete(Course.find(params[:course]))
    redirect_to "/carts/#{@cart.id}"
  end

  private

  def set_cart
    unless current_user.cart.nil?
      @cart = Cart.find_by_user_id(current_user.id)
    else
      @cart = Cart.create!
    end
  end

  def cart_params
    params[:cart]
  end
end
