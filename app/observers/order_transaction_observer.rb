class OrderTransactionObserver < ActiveRecord::Observer
  observe :order_transaction

  def after_create(order_transaction)
    order_transaction.logger.info('New Transaction')

    val = order_transaction.params.decrypt Devise.secret_key
    # "Unverified: #{JSON.parse(@val)['order_description']}"
    user = User.find_by_email JSON.parse(val)['payer']
    Notification.order_transaction(user).deliver
  end
end
