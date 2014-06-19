# Synchronizes with Canvas and is the link between it and the #Course
# See #Course
class CanvasCourses < ActiveRecord::Base
  extend CanvasModule

  belongs_to :course
  attr_accessible :name # :canvas_id #, :course_id

	def self.update canvas_course
    self.connect_to_canvas_oauth if canvas.nil?
    begin
      this_canvas_course = CanvasCourses.find_by_canvas_id(canvas_course['id'])
			course = this_canvas_course.update_course(canvas_course)
		rescue
      this_canvas_course = CanvasCourses.new
			course = Course.create! name: canvas_course['name'],
				hidden: true,
				syllabus: canvas_course['syllabus_body'],
				description: canvas_course['public_description']
    ensure
      begin
        this_canvas_course.course = course
        this_canvas_course.canvas_id = canvas_course['id']
        this_canvas_course.name = canvas_course['name']
        this_canvas_course.syllabus = canvas_course['syllabus_body']
        this_canvas_course.save
      end unless this_canvas_course.nil?
    end
    this_canvas_course
	end

  def self.update_all
    self.connect_to_canvas_oauth if canvas.nil?

    canvas.get('/api/v1/accounts/1/courses?per_page=100').as_json.each do |canvas_course|
      update canvas_course
    end
  end

  def add_user(user)
    canvas_add_user CanvasUsers.find_by_user_id(user.id)
  end

	def update_course(canvas_course)
		course = self.course
		p "#{course.id} - #{course.name}"
		if canvas_course['workflow_state'] == "available"
			course.hidden = false
		else
			course.hidden = true
		end
		course.save
		course
	end

  private
  def canvas_add_user(user)
    return if canvas_id.nil?

    CanvasCourses.connect_to_canvas_oauth if CanvasCourses.canvas.nil?

    begin
      CanvasCourses.canvas.post("/api/v1/courses/#{canvas_id}/enrollments", {'enrollment[user_id]' => user.canvas_id, 'enrollment[type]' => 'StudentEnrollment', 'enrollment[notify]' => true})
    rescue => e
      puts $!.inspect, $@
      logger.debug(e)
    end
  end
end
