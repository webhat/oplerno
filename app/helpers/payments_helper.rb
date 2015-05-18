module PaymentsHelper

  def payment_service_for_cart cart, *args, &block
    cart.courses.each do |item|
      yield item
    end
  end
end
