class CartsCourses < ActiveRecord::Base
  validates_uniqueness_of :cart_id, :scope => :course_id

  belongs_to :cart
  belongs_to :course
  # attr_accessible :title, :body
end
