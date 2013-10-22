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
end
