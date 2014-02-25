# Stores the transactions for each order.
class OrderTransaction < ActiveRecord::Base
  encrypt_with_public_key :params,
                          :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')

  attr_accessible :action, :amount, :authorization, :message, :params, :success, :response, :txn_id #, :order_id

  belongs_to :order
  delegate :cart_id, :to => :order, :prefix => true

  def response=(response)
    self.success = response.success?
    self.authorization = response.authorization
    self.message = response.message
    self.txn_id = response.params['payer_id']
    self.params = response.params.to_json
  rescue ActiveMerchant::ActiveMerchantError => e
    self.success = false
    self.authorization = nil
    self.message = e.message
    self.params = {}.to_json
  end
end
