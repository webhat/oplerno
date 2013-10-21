class Teacher < User

  #property :courses, :type => Array
  property :course_keys, Array, :default => []
  many :courses, :using => :stored_key

  def initialize(init = {})
    init = {} if init.nil?
    super(init)
  end
end
