# Synchronizes with Canvas and is the link between it and the #Course
# See #Course
class CanvasCourses < ActiveRecord::Base
  extend CanvasModule

  belongs_to :course
  attr_accessible :canvas_id, :name#, :course_id

  def self.update canvas_course
    self.connect_to_canvas_oauth if canvas.nil?
    begin
      this_canvas_course = CanvasCourses.find_by_canvas_id (canvas_course['id'])
      course = this_canvas_course.course
      rescue
      this_canvas_course = CanvasCourses.new
      course = Course.create! name: canvas_course['name']
    ensure
      begin
        this_canvas_course.course = course
        this_canvas_course.canvas_id = canvas_course['id']
        this_canvas_course.name = canvas_course['name']
        this_canvas_course.save
      end unless this_canvas_course.nil?
    end
  end

  def self.update_all
    self.connect_to_canvas_oauth if canvas.nil?

    canvas.get('/api/v1/accounts/1/courses').as_json.each do |canvas_course|
      update canvas_course
    end
  end
end
