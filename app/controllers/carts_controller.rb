# Maintains the #Cart, each #Cart is tied to only one user. And once paid for it is transfered to Instructure.
#
# Links to #Courses using #CartsCourses
class CartsController < InheritedResources::Base
  before_filter :set_cart, only: [:create, :show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  helper_method :remove_course_from_cart_url, :remove_course_from_cart, :logged_in?

  def index
    redirect_to "/carts/mycart"
  end

  def create
    @cart.user_id = current_user.id
    course = Course.find(session[:course_id])
    if course.price.to_i > 0
			unless current_user.courses.include?(course)
				if course.users.count < course.max
					@cart.courses << course unless @cart.courses.include?(course)
					flash[:notice] = (I18n.t 'courses.success.add_to_cart')
				else
					flash[:alert] = (I18n.t 'courses.fail.too_many')
				end
			else
				flash[:alert] = (I18n.t 'courses.fail.already_in')
			end
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
    course = Course.find(params[:course])
    @cart.courses.delete(course)
    flash[:notice] = (I18n.t 'cart.removed', {course: course.name})
    redirect_to "/carts/#{@cart.id}"
  end

  private

  def set_cart
    if current_user.nil?
      return @cart = nil
    end

    unless current_user.cart.nil?
      @cart = Cart.find_by_user_id(current_user.id)
    else
      @cart = current_user.build_cart
    end
  end

  def cart_params
    params[:cart]
  end
end
