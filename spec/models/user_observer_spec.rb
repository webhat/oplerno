require 'spec_helper'

describe UserObserver, :type => :observer do
	subject { UserObserver.instance }

	context 'create User' do
		vcr_options = {record: :once}

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

		it 'should send a faculty mail if a teacher is created', vcr: vcr_options do
			#User.any_instance.should_receive(:is_teacher?).and_return(true)
			notification = double(Notification)
			expect(notification).to receive(:deliver)
			allow(Notification).to receive(:faculty_invite).and_return(notification)

			User.observers.enable :user_observer do
				user = FactoryGirl.build(:user, email: 'user_observer_1@oplerno.com', privateemail: 'facultyinvite@example.com')
				user.save
			end
		end

		it 'creates a CanvasUser', :vcr => vcr_options do
			canvas_user = double(CanvasUsers)
			#expect_any_instance_of(Canvas::API).to receive(:post).and_return(canvas_user)
			allow(CanvasUsers).to receive(:create).and_return(canvas_user)
			allow(CanvasUsers).to receive(:update).with(canvas_user)
			expect_any_instance_of(CanvasUsers).to receive(:canvas_sync)

			User.observers.enable :user_observer do
				FactoryGirl.create(:user, email: 'user_observer_2@oplerno.com', privateemail: 'facultyinvite@example.com')
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

		it 'should link User to Ranking' do
			pending 'fix this on next refactor'
			user = double(User)

			User.observers.enable :user_observer do
				user = FactoryGirl.create(:user)
			end
			user.should respond_to(:rank)
			user.rank.should respond_to(:user)
			user.should eq user.rank.user
		end
	end
end
