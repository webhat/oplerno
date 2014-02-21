require 'spec_helper'

describe Student do
  it "has a valid factory"                do
    FactoryGirl.create(:student).should be_valid
  end
  it "is invalid without a email"       do
    FactoryGirl.build(:student, email: nil).should_not be_valid
  end
  it "is invalid without a password"  do
    FactoryGirl.build(:student, password: nil).should_not be_valid
  end
  it 'can have one course attached'
  it 'can have more than one course attached'
  it 'can be updated'
  it 'can be hidden'
  it 'can be unhidden'
end
