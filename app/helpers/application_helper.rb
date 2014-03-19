module ApplicationHelper
	def url_prefix request
		return "#{request.protocol}#{request.host_with_port}" #if Rails.env.development?
		# "https://#{request.host_with_port}"
	end

	def from_canvas request
		return URI(request.referer).host == ::CANVAS_HOST unless request.referer.nil?
		false
	end
end
