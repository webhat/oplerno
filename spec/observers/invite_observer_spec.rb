require 'spec_helper'

describe InviteObserver do
  context do
    it 'should call after_create on observer' do
      expect_any_instance_of(described_class).to receive(:after_create).once

      Invite.observers.enable :invite_observer do
        FactoryGirl.create(:invite)
      end
    end
    it 'should send a mail if a Invite is created' do
      im = double(InviteMailer)
      expect(im).to receive(:deliver)
      allow(InviteMailer).to receive(:thanks).and_return(im)

      Invite.observers.enable :invite_observer do
        FactoryGirl.create(:invite)
      end
    end
  end
end
