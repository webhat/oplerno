
class OrderTransaction < ActiveRecord::Base
  encrypt_with_public_key :params,
                          :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')

  attr_accessible :action, :amount, :authorization, :message, :order_id, :params, :success, :response

  belongs_to :order
  #serialize :params

  def response=(response)
    self.success = response.success?
    self.authorization = response.authorization
    self.message = response.message
    p response.params.to_json
    self.params = response.params.to_json
  rescue ActiveMerchant::ActiveMerchantError => e
    self.success = false
    self.authorization = nil
    self.message = e.message
    self.params = {}
  end
end
