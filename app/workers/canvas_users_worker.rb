class CanvasUsersWorker
	include Sidekiq::Worker
	sidekiq_options queue: 'default'

	def perform(blob)
		CanvasUsers.update blob
		# current_comments.pictures.create!(file: URI.parse(image_url))
	end
end
