require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "has count" do
    assert Course.count.eql?(0)
  end
end
