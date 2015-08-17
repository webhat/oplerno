require 'spec_helper'

describe OrderTransaction do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:order_transaction)).to be_valid
  end

  context 'Strongbox' do
    it 'encrypts secret' do
      ot = FactoryGirl.create(:order_transaction)
      value = {'a' => true}
      json_value = value.to_json
      ot.params = json_value

      expect(ot.params).not_to eq json_value
      expect(ot.params.decrypt Devise.secret_key).to eq json_value
    end
    it 'encrypts secret' do
      ot = OrderTransaction.new
      value = {'a' => true}
      json_value = value.to_json
      ot.params = json_value

      expect(ot.params).not_to eq json_value
      expect(ot.params.decrypt Devise.secret_key).to eq json_value
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

      value = GATEWAY.purchase(
        (response.params['order_total'].to_f*100).round,
        token: response.params['token'],
        payer_id: response.params['payer_id']
      )
      expect(GATEWAY).to receive(:purchase).and_return(value)

      order_transaction.response = response
    end
  end
end
