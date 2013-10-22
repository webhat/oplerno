class Course < Parent
  include Ripple::Document
  #include Ripple::EmbeddedDocument

  property :name, String, :presence => true
  property :key, String
  property :price, Float
  property :description, String
  property :teacher_key, String
  one :teacher, :using => :stored_key

  def initialize(init = {})
    init = {} if init.nil?
    super(init)
  end

  property :filename, :type => String
  property :content_type, :type => String
  property :binary_data, :type => String

  def picture=(input_data)
    self.filename = input_data.original_filename
    self.content_type = input_data.content_type.chomp
    self.binary_data = Base64.encode64(input_data.read)
  end
end
