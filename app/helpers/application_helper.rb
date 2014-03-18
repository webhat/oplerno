module ApplicationHelper
	def url_prefix request
		"https://#{request.host_with_port}"
	end
end
