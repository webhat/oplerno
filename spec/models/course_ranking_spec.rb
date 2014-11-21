require 'spec_helper'

describe CourseRanking, type: :observer do
  it 'has a valid factory' do
    FactoryGirl.create(:course_ranking).should be_valid
  end

	it 'accepts a Course' do
		course_ranking = FactoryGirl.build(:course_ranking, {course: @course})
		course_ranking.save
		course_ranking.should be_valid
	end

	context 'Rank Elements' do
		before(:each) do
			@course = Course.create
			@course.create_rank
			@course.rank.course = @course
			@course.rank.save
		end

		it 'should rank :name using the observer' do
			set_course :name, 'Test Course'

			@course.rank.ranking.should eq 10
		end

		it 'should rank :description' do
			set_course :description, Faker::Lorem.paragraph(3)

			@course.rank.ranking.should eq 40
		end
		it 'should rank :teacher'
		it 'should rank :avatar'
		it 'should rank :skills'
		it 'should rank :subjects'
		it 'should rank :syllabus' do
			set_course :syllabus, Faker::Lorem.paragraph(10)

			@course.rank.ranking.should eq 20
		end
		it 'should rank :hidden true' do
			set_course :hidden, true

			@course.rank.ranking.should eq (-10)
		end
		it 'should rank :hidden false' do
			set_course :hidden, false

			@course.rank.ranking.should eq 10
		end
	
		def set_course key, value
			@course[key] = value
			@course.save

			@course.rank.rank
		end
	end
end
