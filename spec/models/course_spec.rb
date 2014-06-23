require 'spec_helper'

describe Course do
  it 'has a valid factory' do
    FactoryGirl.create(:course).should be_valid
  end
  it 'is invalid with an empty name' do
    FactoryGirl.build(:course, name: '').should_not be_valid
  end
  it "is invalid without a name" do
    FactoryGirl.build(:course, name: nil).should_not be_valid
  end
  it 'has a reference to a teacher'
  it 'can be updated'
  it 'can be hidden' do
    FactoryGirl.build(:course, hidden: true).should be_valid
	end
  it 'can be unhidden' do
    FactoryGirl.build(:course, hidden: false).should be_valid
	end
	it 'should add a subject' do
		course = FactoryGirl.create(:course)
		subject = FactoryGirl.create(:subject)

		expect {
			course.subjects << subject
		}.to change(course.subjects, :count).by(1)
	end
	it 'should have the subject' do
		course = FactoryGirl.create(:course)
		subject = FactoryGirl.create(:subject)

		course.subjects << subject
		expect(course.subjects[0]).to eq subject
	end
	it 'should add a skill' do
		course = FactoryGirl.create(:course)
		skill = FactoryGirl.create(:skill)

		expect {
			course.skills << skill
		}.to change(course.skills, :count).by(1)
	end
	it 'should have the skill' do
		course = FactoryGirl.create(:course)
		skill = FactoryGirl.create(:skill)

		course.skills << skill
		expect(course.skills[0]).to eq skill
	end
	it 'should not split string with one skill' do 
		skills = Course.split 'something'
		skills[0].should eq 'something'
	end
	it 'should split a list of skills' do 
		skills = Course.split 'something,somethingelse'
		skills[0].should eq 'something'
		skills[1].should eq 'somethingelse'
	end
	it 'should work with reference string' do
		skills = Course.split 'Critical Thinking, Pedagogy, Technology, Post-Modernism'
		skills[0].should eq 'Critical Thinking'
		skills[2].should eq 'Technology'
	end
end
