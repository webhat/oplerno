require 'spec_helper'

describe Subject do
	context 'assigns values' do
		it 'to subject' do
			s = Subject.create! subject: 'A Random Subject'
			expect(s.subject).to eq 'A Random Subject'
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
end
