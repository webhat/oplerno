class OrderObserver < ActiveRecord::Observer
  observe :order

  def after_create(order)
    order.logger.info('New Order')

    Notification.order( order.user ).deliver
  end
end
