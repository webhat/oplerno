module ApplicationHelper
	def url_prefix request
<<<<<<< HEAD
		return "#{request.protocol}#{request.host_with_port}" #if Rails.env.development?
		# "https://#{request.host_with_port}"
=======
		@prefix ||= begin
			"#{request.protocol}#{request.host_with_port}" #if Rails.env.development?
		rescue
			"https://#{request.host_with_port}"
		end
>>>>>>> e55f7f3... change ruby version
	end

	def from_canvas request
		return URI(request.referer).host == ::CANVAS_HOST unless request.referer.nil?
		false
	end

	def avatar num
		course = @courses[num]
		unless course.nil?
			course.avatar.url(:medium)
		end
	end
end
