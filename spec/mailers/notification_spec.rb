require 'spec_helper'

describe Notification, :type => :mailer do
	before { ActionMailer::Base.deliveries = [] }

	it 'should accept a user model' do
		Notification.new_user(FactoryGirl.create(:user)).deliver
		ActionMailer::Base.deliveries.should_not be_empty
	end
	it 'should send an email to a faculty member' do
		user = FactoryGirl.create(:user)
		faculty_mail = Notification.faculty_invite(user)

		expect(faculty_mail.to[0]).to eq(user.privateemail)

		faculty_mail.deliver
		ActionMailer::Base.deliveries.should_not be_empty
	end
	it 'should send an email to the admin' do
		user = FactoryGirl.create(:user)
		faculty_mail = Notification.new_user(user)

		expect(faculty_mail.to[0]).to eq('webmaster@oplerno.com')

		faculty_mail.deliver
		ActionMailer::Base.deliveries.should_not be_empty
	end
end
