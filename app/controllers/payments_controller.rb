class PaymentsController < InheritedResources::Base
  include ActiveMerchant::Billing::Integrations

  def new
    @enrollment = current_user.cart
  end
end
