require 'spec_helper'

describe OrderTransactionObserver do
  subject { described_class.instance }

  context '#create' do
    it 'should call after_create on observer' do
      expect(subject).to receive(:after_create)

      OrderTransaction.observers.enable :order_transaction_observer do
        FactoryGirl.create(:order_transaction)
      end
    end
    it 'should call after_create on observer' do
      expect_any_instance_of(described_class).to receive(:after_create).once

      OrderTransaction.observers.enable :order_transaction_observer do
        FactoryGirl.create(:order_transaction)
      end
    end
    it 'should send a mail if an OrderTransaction is created' do
      payer = '{"payer": "observer@oplerno.com"}'

      notification = double(Notification)
      expect(notification).to receive(:deliver)

      allow(Notification).to receive(:order_transaction).and_return(
        notification
      )

      OrderTransaction.observers.enable :order_transaction_observer do
        ot = FactoryGirl.build(:order_transaction, params: payer)
        ot.save
      end
    end
  end
end
