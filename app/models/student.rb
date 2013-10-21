class Student < User
  include Ripple::Document

  def initialize(init = {})
    init = {} if init.nil?
    super(init)
  end
end
