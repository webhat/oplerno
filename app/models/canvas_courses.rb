# Synchronizes with Canvas and is the link between it and the #Course
# See #Course
class CanvasCourses < ActiveRecord::Base
  extend CanvasModule

  belongs_to :course
  attr_accessible :name # :canvas_id #, :course_id

  def self.update canvas_course
    this_canvas_course = CanvasCourses.find_by_canvas_id(canvas_course['id'])
    if this_canvas_course.nil?
      this_canvas_course = CanvasCourses.new
    end

    this_canvas_course.update_course(canvas_course)

    this_canvas_course.canvas_id = canvas_course['id']
    this_canvas_course.name = canvas_course['name']
    puts this_canvas_course.name.force_encoding('UTF-8')
    this_canvas_course.syllabus = canvas_course['syllabus_body']
    this_canvas_course.save
  end

  def self.update_all
    self.connect_to_canvas_oauth if canvas.nil?

    [1,2,3,4,5].each{ |page|
      canvas.get("/api/v1/accounts/1/courses?per_page=100&page=#{page}").as_json.each do |canvas_course|
        # CanvasCoursesWorker.perform_async canvas_course
        self.update canvas_course
      end
    }
  end

  def add_user(user)
    canvas_add_user CanvasUsers.find_by_user_id(user.id)
  end

  def update_course(canvas_course)
    course = self.course
    course = Course.create! name: canvas_course['name'], hidden: true if course.nil?

    #   if canvas_course['workflow_state'] == "available"
    #     course.hidden = false
    #   else
    #     course.hidden = true
    #   end
    course.teacher = canvas_get_teacher
    PaperTrail.whodunnit = 6
    course.save
    self.course = course
  end

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

  def canvas_get_teacher
    return if canvas_id.nil?

    CanvasCourses.connect_to_canvas_oauth if CanvasCourses.canvas.nil?

    begin
      canvas_teacher = CanvasCourses.canvas.get("/api/v1/courses/#{canvas_id}/search_users", {'enrollment_roll' => 'TeacherEnrollment'})[0]
      unless canvas_teacher.nil?
        User.find_by_email canvas_teacher['login_id']
      end
    rescue => e
      puts $!.inspect, $@
      logger.debug(e)
      nil
    end
  end
end
