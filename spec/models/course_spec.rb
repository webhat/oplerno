require 'spec_helper'

describe Course do
  context 'Factory' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:course)).to be_valid
    end
    it 'is invalid with an empty name' do
      expect(FactoryGirl.build(:course, name: '')).to_not be_valid
    end
    it "is invalid without a name" do
      expect(FactoryGirl.build(:course, name: nil)).to_not be_valid
    end
    it 'can be hidden' do
      expect(FactoryGirl.build(:course, hidden: true)).to be_valid
    end
    it 'can be unhidden' do
      expect(FactoryGirl.build(:course, hidden: false)).to be_valid
    end
  end
  context 'has a' do
    let (:course) { create :course }
    it 'should have teacher' do
      skip 'Infitite Loop'
      expect {
        course.teachers << FactoryGirl.create(:teacher)
      }.to change(course.teachers, :count).by(1)
    end
    it 'should add a subject' do
      subject = FactoryGirl.create(:subject)

      expect {
        course.subjects << subject
      }.to change(course.subjects, :count).by(1)
    end
    it 'should have the subject' do
      subject = FactoryGirl.create(:subject)

      course.subjects << subject
      expect(course.subjects[0]).to eq subject
    end
    it 'should add a skill' do
      skill = FactoryGirl.create(:skill)

      expect {
        course.skills << skill
      }.to change(course.skills, :count).by(1)
    end
    it 'should have the skill' do
      skill = FactoryGirl.create(:skill)

      course.skills << skill
      expect(course.skills[0]).to eq skill
    end
    it 'should not split string with one skill' do 
      skills = Course.split 'something'
      expect(skills[0]).to eq 'something'
    end
    it 'should split a list of skills' do 
      skills = Course.split 'something,somethingelse'
      expect(skills[0]).to eq 'something'
      expect(skills[1]).to eq 'somethingelse'
    end
    it 'should work with reference string' do
      skills = Course.split 'Critical Thinking, Pedagogy, Technology, Post-Modernism'
      expect(skills[0]).to eq 'Critical Thinking'
      expect(skills[2]).to eq 'Technology'
    end
  end
end
