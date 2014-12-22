class CanvasCoursesWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(blob)
    CanvasCourses.update blob
  end
end
