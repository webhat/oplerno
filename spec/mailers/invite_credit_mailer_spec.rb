require 'spec_helper'

describe InviteCreditMailer do
  context 'Mailers' do
    it 'should send an email to invited user email' do
      user = FactoryGirl.create(:user)
      by = FactoryGirl.create(:user)
      ic = InviteCredit.create! user: user, by: by

      invite_credit_mailer = described_class.by_user(ic)

      expect(invite_credit_mailer.to[0]).to eq(user.email)

      invite_credit_mailer.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
    it 'should send an email to invited user email with subject' do
      user = FactoryGirl.create(:user)
      by = FactoryGirl.create(:user)
      ic = InviteCredit.create! user: user, by: by

      invite_credit_mailer = described_class.by_user(ic)

      subject = I18n.t('invites.invite_credit.notification', amount: '50')
      expect(invite_credit_mailer.subject).to eq(subject)

      invite_credit_mailer.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
    it 'should send an email to inviting user email' do
      user = FactoryGirl.create(:user)
      ic = InviteCredit.create! user: user, by: user

      invite_credit_mailer = described_class.by_user(ic)

      expect(invite_credit_mailer.to[0]).to eq(user.email)

      invite_credit_mailer.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
    it 'should send an email to inviting user email with subject' do
      user = FactoryGirl.create(:user)
      ic = InviteCredit.create! user: user, by: user

      invite_credit_mailer = described_class.by_user(ic)

      subject = I18n.t('invites.invite_credit.accepted', amount: '50')

      expect(invite_credit_mailer.subject).to eq(subject)

      invite_credit_mailer.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
    it 'should send an email to user unconfirmed_email' do
      user = FactoryGirl.create(:user)
      user.unconfirmed_email = Faker::Internet.email
      by = FactoryGirl.create(:user)
      ic = InviteCredit.create! user: user, by: by

      invite_credit_mailer = described_class.by_user(ic)

      expect(invite_credit_mailer.to[0]).to eq(user.unconfirmed_email)

      invite_credit_mailer.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end
end
