require 'spec_helper'

describe UserObserver, :type => :observer do
  subject { described_class.instance }
  let (:teacher_user)   { {
    email: 'user_observer_1@oplerno.com',
    privateemail: Faker::Internet.email
  } }

  context 'create User' do
    vcr_options = {record: :once}

    it 'should call after_create on observer' do
      expect(subject).to receive(:after_create)

      User.observers.enable :user_observer do
        FactoryGirl.create(:user)
      end
    end

    it 'should call after_create on observer' do
      expect_any_instance_of(described_class).to receive(:after_create).once

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
      notification = double(Notification)
      expect(notification).to receive(:deliver)
      allow(Notification).to receive(:faculty_invite).and_return(notification)

      User.observers.enable :user_observer do
        user = FactoryGirl.build(:user, teacher_user)
        user.save
      end
    end

    it 'creates a CanvasUser', :vcr => vcr_options do
      canvas_user = double(CanvasUsers)
      allow(CanvasUsers).to receive(:create).and_return(canvas_user)
      allow(CanvasUsers).to receive(:update).with(canvas_user)
      expect_any_instance_of(CanvasUsers).to receive(:canvas_sync)

      User.observers.enable :user_observer do
        FactoryGirl.create(:user, teacher_user)
      end
    end
  end
  context 'save User' do
    it 'should call after_create on observer' do
      expect(subject).to receive(:after_save)

      user = FactoryGirl.create(:user)

      User.observers.enable :user_observer do
        user.save
      end
    end

    it 'should call after_create on observer' do
      expect_any_instance_of(described_class).to receive(:after_save).once

      user = FactoryGirl.create(:user)
      User.observers.enable :user_observer do
        user.save
      end
    end
    it 'should create a ranking if a teacher is saved' do
      user = FactoryGirl.build(:user, teacher_user)

      User.observers.enable :user_observer do
        user.save
      end

      teacher = Teacher.find(user.id)
      expect( teacher.rank ).to_not be_nil
      expect( teacher.rank.teacher ).to_not be_nil
    end

    it 'should link User to Ranking' do
      pending 'fix this on next refactor'
      user = double(User)

      User.observers.enable :user_observer do
        user = FactoryGirl.create(:user)
      end
      expect( user ).to respond_to(:rank)
      expect( user.rank ).to respond_to(:user)
      expect( user ).to eq user.rank.user
    end
  end
end
