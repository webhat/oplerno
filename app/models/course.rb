class Course  < ActiveRecord::Base

  validates_presence_of :name

  attr_accessible :name, :key, :price,
                  :description, :teacher,
                  :filename, :content_type,
                  :binary_data

  has_many :teachers
  has_many :students
  has_and_belongs_to_many :carts

  def picture=(input_data)
    self.filename = input_data.original_filename
    self.content_type = input_data.content_type.chomp
    self.binary_data = Base64.encode64(input_data.read)
  end
end
