require 'spec_helper'

describe Subject do
  context 'assigns values' do
    it 'to subject' do
      subject = Subject.create! subject: 'A Random Subject'
      expect(subject.subject).to eq 'A Random Subject'
    end
    it { should validate_presence_of :subject }
  end
  context 'factory' do
    it "should be valid factory" do
      FactoryGirl.build(:subject).should be_valid
    end
    it "should require a subject" do
      FactoryGirl.build(:subject, subject: "").should_not be_valid
    end
  end
  context 'courses' do 
    before(:each) do
      @subject = FactoryGirl.create(:subject)
      @course  = FactoryGirl.create(:course)
    end
    it 'can have a course attached' do
      @subject.courses << @course
      expect(@subject.courses[0]).to eq @course
    end
    it 'can have a course attached' do
      expect {
        @subject.courses << @course
      }.to change(@subject.courses, :count).by(1) 
    end
    it 'can have two courses attached' do
      expect {
        @subject.courses << @course
        @subject.courses << FactoryGirl.create(:course)
      }.to change(@subject.courses, :count).by(2) 
    end
  end
end
