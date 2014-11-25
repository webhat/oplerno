require 'spec_helper'

describe CourseObserver, :type => :observer  do
	subject { CourseObserver.instance }

	context 'Create Course' do
		it 'should call after_create on observer' do
			subject.should_receive(:after_create)

			Course.observers.enable :course_observer do
				FactoryGirl.create(:course)
			end
		end

		it 'should call after_create on observer' do
			CourseObserver.any_instance.should_receive(:after_create).once

			Course.observers.enable :course_observer do
				FactoryGirl.create(:course)
			end
		end

		it 'should link Course to Ranking' do
			course = nil

			Course.observers.enable :course_observer do
				course = FactoryGirl.create(:course)
			end
			course.should respond_to(:rank)
			course.rank.should respond_to(:course)
			course.should eq course.rank.course
		end
	end
	context 'Save Course' do
		it 'should call after_save on observer' do
			subject.should_receive(:after_save)
			course = FactoryGirl.create(:course)

			Course.observers.enable :course_observer do
				course.save
			end
		end

		it 'should call after_save on observer' do
			CourseObserver.any_instance.should_receive(:after_save).once
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
			course.rank.should respond_to(:rank)
			course.should eq course.rank.course
			course.rank.ranking.should eq 10
		end
	end
end
