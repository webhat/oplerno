require "spec_helper"

describe MentorMailer do
  let(:mentor) {create :mentor, unconfirmed_email: 'unconfirmed@example.com'}
  it 'should send mail' do
    mentor_mailer = described_class.email_changed mentor
    mentor_mailer.deliver
    ActionMailer::Base.deliveries.should_not be_empty
  end
end
