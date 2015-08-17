require 'spec_helper'

describe Teacher do
  it "has a valid factory"                do
    expect(FactoryGirl.create(:teacher)).to be_valid
  end
  it "is invalid without a email"       do
    expect(FactoryGirl.build(:teacher, email: nil)).to_not be_valid
  end
  it "is invalid without a password"  do
    expect(FactoryGirl.build(:teacher, password: nil)).to_not be_valid
  end
  context 'Ranking' do
    it 'have no ranking' do
      teacher = FactoryGirl.create(:teacher)
      expect(teacher.rank).to be_nil
    end
    it 'have a ranking' do
      teacher = FactoryGirl.create(:teacher)
      teacher.create_rank
      expect(teacher.rank).to_not be_nil
    end
  end
  context '#all' do
    it { expect(described_class.all).to_not be_nil }
  end
end
