class InstructureWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(blob, count)
  end
end
