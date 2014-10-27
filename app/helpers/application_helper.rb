module ApplicationHelper
	def url_prefix request
		begin
			"#{request.protocol}#{request.host_with_port}" #if Rails.env.development?
		rescue
			"https://#{request.host_with_port}"
		end
	end

	def from_canvas request
		return URI(request.referer).host == ::CANVAS_HOST unless request.referer.nil?
		false
	end

	def is_teacher?
		if user_signed_in?
			true
		else
			false
		end
	end

	def avatar num
		course = @courses[num]
		unless course.nil?
			course.avatar.url(:medium)
		end
	end
end
