require "spec_helper"

describe InviteMailer do
  context 'Mailers' do
    it 'should send an email to invited user email' do
      user = FactoryGirl.create(:user)
      invite = Invite.create! user: user

      invite_mailer = described_class.thanks(invite)

      expect(invite_mailer.to[0]).to eq(user.email)

      invite_mailer.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
    it 'should send an email to invited user email with subject' do
      user = FactoryGirl.create(:user)
      invite = Invite.create! user: user

      invite_mailer = described_class.thanks(invite)

      subject = I18n.t('invites.invite.accepted', user: user.email)
      expect(invite_mailer.subject).to eq(subject)

      invite_mailer.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
    it 'should send an email to inviting user email' do
      user = FactoryGirl.create(:user)
      invite = Invite.create! user: user

      invite_mailer = described_class.thanks(invite)

      expect(invite_mailer.to[0]).to eq(user.email)

      invite_mailer.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
    it 'should send an email to inviting user email with subject' do
      user = FactoryGirl.create(:user)
      invite = Invite.create! user: user

      invite_mailer = described_class.thanks(invite)

      subject = I18n.t('invites.invite.accepted', user: user.email)

      expect(invite_mailer.subject).to eq(subject)

      invite_mailer.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end
end
