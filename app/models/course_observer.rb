class CourseObserver < ActiveRecord::Observer
	def after_create(course)
		course.create_rank
		course.rank.course = course
		course.save
	end

	def after_save(course)
		course.create_rank if course.rank.nil?

		course.rank.rank
		course.rank.save
	end
end
