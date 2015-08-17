require 'spec_helper'

describe CourseObserver, :type => :observer  do
  subject { CourseObserver.instance }

  context 'Create Course' do
    it 'should call after_create on observer' do
      expect( subject ).to receive(:after_create)

      Course.observers.enable :course_observer do
        FactoryGirl.create(:course)
      end
    end

    it 'should call after_create on observer' do
      expect_any_instance_of(described_class).to receive(:after_create).once

      Course.observers.enable :course_observer do
        FactoryGirl.create(:course)
      end
    end

    it 'should link Course to Ranking' do
      course = nil

      Course.observers.enable :course_observer do
        course = FactoryGirl.create(:course)
      end
      expect( course ).to respond_to(:rank)
      expect( course.rank ).to respond_to(:course)
      expect( course ).to eq course.rank.course
    end
  end
  context 'Save Course' do
    it 'should call after_save on observer' do
      expect( subject ).to receive(:after_save)
      course = FactoryGirl.create(:course)

      Course.observers.enable :course_observer do
        course.save
      end
    end

    it 'should call after_save on observer' do
      expect_any_instance_of(described_class).to receive(:after_save).once
      course = FactoryGirl.create(:course)

      Course.observers.enable :course_observer do
        course.save
      end
    end

    it 'should update course.rank.ranking after_save' do
      course = FactoryGirl.create(:course)

      Course.observers.enable :course_observer do
        course.save
      end
      expect( course.rank ).to respond_to(:rank)
      expect( course ).to eq course.rank.course
      expect( course.rank.ranking ).to eq 15
    end

    it 'should send a mail if a teacher is added to a course' do
      skip
      course_mailer = double(CourseMailer)
      expect(course_mailer).to receive(:deliver)
      expect(CourseMailer).to receive(:new_teacher).and_return(course_mailer)
      course = Course.create! name: 'blank'

      Course.observers.enable :course_observer do
        course.teacher = FactoryGirl.create(:user).id
        course.save
      end
    end
  end
end
