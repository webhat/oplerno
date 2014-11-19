require 'spec_helper'

describe UserObserver, :type => :observer do
	subject { UserObserver.instance }

	context 'create User' do
		it 'should call after_create on observer' do
			subject.should_receive(:after_create)

			User.observers.enable :user_observer do
				FactoryGirl.create(:user)
			end
		end

		it 'should call after_create on observer' do
			UserObserver.any_instance.should_receive(:after_create).once

			User.observers.enable :user_observer do
				FactoryGirl.create(:user)
			end
		end

		it 'should send a mail if a user is created' do
			notification = double(Notification)
			expect(notification).to receive(:deliver)
			allow(Notification).to receive(:new_user).and_return(notification)

			User.observers.enable :user_observer do
				FactoryGirl.create(:user)
			end
		end

		it 'should not send a faculty mail if a teacher not is created' do
			notification = double(Notification)
			expect(notification).to_not receive(:deliver)
			allow(Notification).to receive(:faculty_invite).and_return(notification)

			User.observers.enable :user_observer do
				FactoryGirl.create(:user)
			end
		end

		it 'should send a faculty mail if a teacher is created' do
			#User.any_instance.should_receive(:is_teacher?).and_return(true)
			notification = double(Notification)
			expect(notification).to receive(:deliver)
			allow(Notification).to receive(:faculty_invite).and_return(notification)

			User.observers.enable :user_observer do
				user = FactoryGirl.build(:user, email: 'user_observer_1@oplerno.com', privateemail: 'facultyinvite@example.com')
				user.save
			end
		end
	end
	context 'save User' do
		it 'should call after_create on observer' do
			subject.should_receive(:after_save)

			user = FactoryGirl.create(:user)

			User.observers.enable :user_observer do
				user.save
			end
		end

		it 'should call after_create on observer' do
			UserObserver.any_instance.should_receive(:after_save).once

			user = FactoryGirl.create(:user)
			User.observers.enable :user_observer do
				user.save
			end
		end
		it 'should create a ranking if a teacher is saved' do
			user = FactoryGirl.build(:user, email: 'user_observer_2@oplerno.com', privateemail: Faker::Internet.email)

			User.observers.enable :user_observer do
				user.save
			end

			teacher = Teacher.find(user.id)
			teacher.rank.should_not be_nil
			teacher.rank.teacher.should_not be_nil
		end
	end
end
