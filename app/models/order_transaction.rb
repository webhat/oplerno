# Stores the transactions for each order.
class OrderTransaction < ActiveRecord::Base
  encrypt_with_public_key :params,
                          :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')

  encrypt_with_public_key :params_completed,
                          :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')

  attr_accessible :action, :amount, :authorization, :message, :success, :response, :txn_id #, :order_id

  belongs_to :order
  delegate :cart_id, :to => :order, :prefix => true

  def response=(response)
    self.success = response.success?
    self.authorization = response.authorization
    self.message = response.message
    self.txn_id = response.params['payer_id']
    self.params = response.params.to_json
		if response.success?
			completed = GATEWAY.purchase((response.params['order_total'].to_f*100).round, token: response.params['token'], payer_id: response.params['payer_id'])
			self.params_completed = completed.params.to_json
		end
  rescue ActiveMerchant::ActiveMerchantError => e
		p e
    self.success = false
    self.authorization = nil
    self.message = e.message
    self.params = {}.to_json
  end
end
