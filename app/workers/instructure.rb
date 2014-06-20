class Instructure
	include Sidekiq::Worker
	sidekiq_options queue: 'default'

	def perform(blob)
	end
end
