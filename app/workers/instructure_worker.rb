class InstructureWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(blob, count)
  end
end

#  vim: set ts=2 sw=2 tw=0 et :
