module ApplicationHelper
	def url_prefix request
		"#{request.protocol}#{request.host_with_port}"
	end
end
