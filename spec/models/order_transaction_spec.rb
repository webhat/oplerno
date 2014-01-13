require 'spec_helper'

describe OrderTransaction do
  it "has a valid factory" do
    pending 'Bug in FactoryGirl'
    FactoryGirl.create(:order_transactions).should be_valid
  end

  describe 'Strongbox' do
    it 'encrypts secret' do
      pending 'Bug in FactoryGirl'
      user = FactoryGirl.create(:order_transactions)
      value = {'a' => true}
      user.params = value.to_json

      expect(user.params).not_to eq value.to_json
      expect(user.params.decrypt Devise.secret_key).to eq value.to_json
    end
    it 'encrypts secret' do
      user = OrderTransaction.new
      value = {'a' => true}
      user.params = value.to_json
      expect(user.params).not_to eq value.to_json
      expect(user.params.decrypt Devise.secret_key).to eq value.to_json
    end
  end
end
