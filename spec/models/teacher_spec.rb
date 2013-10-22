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
  it "returns a contact's key as a hash" do
    user = FactoryGirl.create(:teacher)
    user.key.should eq Digest::MD5.hexdigest user.email
  end
  it 'can have one course attached'
  it 'can have more than one course attached'
  it 'can be updated'
  it 'can be hidden'
  it 'can be unhidden'
end
