require 'spec_helper'

describe Order do
  it "has a valid factory" do
    expect(FactoryGirl.create(:order)).to be_valid
  end
end
