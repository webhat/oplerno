require 'spec_helper'

describe Course do
  it "has a valid factory" do
    FactoryGirl.create(:course).should be_valid
  end
  it "is invalid without a name" do
    FactoryGirl.build(:course, name: nil).should_not be_valid
  end
  it 'has a reference to a teacher'
  it 'can be updated'
  it 'can be hidden'
  it 'can be unhidden'
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
end
