namespace :debug do
	def pp_txn
		@pp_txn ||= JSON[@txn.params.decrypt Devise.secret_key]
	end

	task :transaction => :environment do |t, args|
		order = Order.find(ENV['ORDER'])
		@txn = order.transactions[0]

		p @txn.txn_id
		p pp_txn['token']
		p pp_txn

#		setup = GATEWAY.purchase(100, token: pp_txn['token'], payer_id: @txn.txn_id)
#		p setup
	end
end
