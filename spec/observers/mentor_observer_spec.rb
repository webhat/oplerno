require 'spec_helper'

describe MentorObserver do
  it 'should call before_save on observer' do
    expect_any_instance_of(described_class).to receive(:after_save)
    mentor = FactoryGirl.create(:mentor)

    Mentor.observers.enable :mentor_observer do
      mentor.save
    end
  end
  it 'should check email is changed before_save on observer' do
    expect_any_instance_of(described_class).to receive(:after_save)
    mentor = FactoryGirl.create(:mentor)

    Mentor.observers.enable :mentor_observer do
      mentor.unconfirmed_email = 'test@oplerno.com'
      mentor.save
    end
  end
  it 'should check email is changed before_save on observer' do
    mentor = FactoryGirl.create(:mentor)
    mentor_mailer = double(MentorMailer)
    allow(MentorMailer).to receive(:email_changed).and_return(mentor_mailer)
    expect(mentor_mailer).to receive(:deliver)

    Mentor.observers.enable :mentor_observer do
      mentor.unconfirmed_email = 'test@oplerno.com'
      mentor.save
    end
  end
end
