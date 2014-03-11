#
class Course < ActiveRecord::Base
	searchkick
	paginates_per 24

  attr_accessible :avatar
  has_attached_file :avatar, :styles => {:medium => "265x265>", :thumb => "100x100>"},
                    :default_url => "/assets/:style/missing.png"

  validates_presence_of :name

  attr_accessible :name, :key, :price,
                  :description, :teacher,
                  :filename, :content_type,
                  :binary_data, :picture,
									:subjects, :subject,
									:start_date, :subject_list

  default_scope :order => 'created_at DESC'

  has_many :teachers
  has_many :students
  has_and_belongs_to_many :carts
  has_one :canvas_course

	has_and_belongs_to_many :subjects

  def active?
    self.price.to_f > 0
  end

	def subject=(_subject)
		return if _subject.empty?
		v = Subject.find(_subject)
		subjects << v unless subjects.include?(v)
	end

	def subject
		subjects[0]
	end

	def subject_list= list
		self.subjects = list.map{|x| Subject.find(x)}
	end
end
