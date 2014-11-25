require 'spec_helper'

describe Teacher do
  it "has a valid factory"                do
    FactoryGirl.create(:teacher).should be_valid
  end
  it "is invalid without a email"       do
    FactoryGirl.build(:teacher, email: nil).should_not be_valid
  end
  it "is invalid without a password"  do
    FactoryGirl.build(:teacher, password: nil).should_not be_valid
  end
  it 'can have one course attached'
  it 'can have more than one course attached'
  it 'can be updated'
  it 'can be hidden'
  it 'can be unhidden'

	it 'have no ranking' do
		teacher = FactoryGirl.create(:teacher)
		teacher.rank.should be_nil
	end

	it 'have a ranking' do
		teacher = FactoryGirl.create(:teacher)
		teacher.create_rank
		teacher.rank.should_not be_nil
	end
	context '#all' do
		it { expect(described_class.all).to_not be_nil }
	end
end
