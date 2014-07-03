module ApplicationHelper
	def url_prefix request
		@prefix ||= begin
			"#{request.protocol}#{request.host_with_port}" #if Rails.env.development?
		rescue
			"https://#{request.host_with_port}"
		end
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
