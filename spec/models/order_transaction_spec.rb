require 'spec_helper'

describe OrderTransaction do
  it "has a valid factory" do
    FactoryGirl.create(:order_transaction).should be_valid
  end

  context 'Strongbox' do
    it 'encrypts secret' do
      order_transaction = FactoryGirl.create(:order_transaction)
      value = {'a' => true}
      order_transaction.params = value.to_json

      expect(order_transaction.params).not_to eq value.to_json
      expect(order_transaction.params.decrypt Devise.secret_key).to eq value.to_json
    end
    it 'encrypts secret' do
      order_transaction = OrderTransaction.new
      value = {'a' => true}
      order_transaction.params = value.to_json
      expect(order_transaction.params).not_to eq value.to_json
      expect(order_transaction.params.decrypt Devise.secret_key).to eq value.to_json
    end
	end
	context 'PayPal' do
    vcr_options = {record: :once}
		# Don't change the names or cassettes or this will fail
		it 'makes a successful request', :vcr => vcr_options do
			response = GATEWAY.details_for('EC-2OPN7UJGFWK9OYFV')
			expect(response).to_not eq nil
			expect(response.success?).to eq true
		end
		# Don't change the names or cassettes or this will fail
		it 'throws an error', :vcr => vcr_options do
			GATEWAY.stub(:purchase).and_return(nil)
			expect(GATEWAY).to_not have_received(:purchase)

      order_transaction = FactoryGirl.create(:order_transaction)
			response = GATEWAY.details_for('EC-2OPN7UJGFWK9OYFV')
			expect(response).to_not eq nil
			expect(response.success?).to eq false
			
			order_transaction.response = response
		end
		it 'makes a successful purchase', :vcr => vcr_options do
			response = GATEWAY.details_for('EC-2OPN7UJGFWK9OYFV')
			expect(response).to_not eq nil
			expect(response.success?).to eq true
			response.params['order_total'] = 100
			order_transaction = FactoryGirl.create(:order_transaction)
			#GATEWAY.stub(:purchase).and_return(nil)
			
			value = GATEWAY.purchase((response.params['order_total'].to_f*100).round, token: response.params['token'], payer_id: response.params['payer_id'])
			expect(GATEWAY).to receive(:purchase).and_return(value)

			order_transaction.response = response
		end
  end
end
