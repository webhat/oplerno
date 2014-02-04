#
class Course < ActiveRecord::Base
	paginates_per 25

  attr_accessible :avatar
  has_attached_file :avatar, :styles => {:medium => "265x265>", :thumb => "100x100>"},
                    :default_url => "/assets/:style/missing.png"

  validates_presence_of :name

  attr_accessible :name, :key, :price,
                  :description, :teacher,
                  :filename, :content_type,
                  :binary_data, :picture

  default_scope :order => 'created_at DESC'

  has_many :teachers
  has_many :students
  has_and_belongs_to_many :carts
  has_one :canvas_course

  def active?
    self.price.to_f > 0
  end
end
