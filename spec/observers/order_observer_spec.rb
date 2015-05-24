require 'spec_helper'

describe OrderObserver do
  subject { described_class.instance }

  context '#create' do
    it 'should call after_create on observer' do
      expect(subject).to receive(:after_create)

      Order.observers.enable :order_observer do
        FactoryGirl.create(:order)
      end
    end
    it 'should call after_create on observer' do
      expect_any_instance_of(described_class).to receive(:after_create).once

      Order.observers.enable :order_observer do
        FactoryGirl.create(:order)
      end
    end
    it 'should send a mail if an Order is created' do
      notification = double(Notification)
      expect(notification).to receive(:deliver)

      allow(Notification).to receive(:order).and_return(
        notification
      )

      Order.observers.enable :order_observer do
        FactoryGirl.create(:order)
      end
    end
  end
end
