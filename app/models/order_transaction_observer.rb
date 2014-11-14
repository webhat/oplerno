class OrderTransactionObserver < ActiveRecord::Observer
	observe :order_transaction

	def after_create(order_transaction)
		order_transaction.logger.info('New Transaction')
	end
end
