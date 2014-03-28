#
class Cart < ActiveRecord::Base
  has_one :order
  belongs_to :user
  has_and_belongs_to_many :courses, uniq: true

  default_scope :order => 'created_at DESC'

  attr_accessible :total_price, :purchased_at, :courses #, :user_id

  def total_price
    courses.compact.map(&:price).inject(0, &:+)
  end

  def courses_to_student
    student = Student.find(user.id)

    courses.each { |course|
      student.courses << course

      canvas_courses = CanvasCourses.find_by_course_id(course.id)
      canvas_courses.add_user(user) unless canvas_courses.nil?
    }
  end
end
