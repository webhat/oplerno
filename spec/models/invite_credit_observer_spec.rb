require 'spec_helper'

describe InviteCreditObserver do
  context do
    it 'should call after_create on observer' do
      expect_any_instance_of(described_class).to receive(:after_create).once

      InviteCredit.observers.enable :invite_credit_observer do
        FactoryGirl.create(:invite_credit)
      end
    end
    it 'should send a mail if a InviteCredit is created' do
      icm = double(InviteCreditMailer)
      expect(icm).to receive(:deliver)
      allow(InviteCreditMailer).to receive(:by_user).and_return(icm)

      InviteCredit.observers.enable :invite_credit_observer do
        FactoryGirl.create(:invite_credit)
      end
    end
  end
end
