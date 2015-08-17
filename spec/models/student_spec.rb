require 'spec_helper'

describe Student do
  it "has a valid factory"                do
    expect(FactoryGirl.create(:student)).to be_valid
  end
  it "is invalid without a email"       do
    expect(FactoryGirl.build(:student, email: nil)).to_not be_valid
  end
  it "is invalid without a password"  do
    expect(FactoryGirl.build(:student, password: nil)).to_not be_valid
  end
end
