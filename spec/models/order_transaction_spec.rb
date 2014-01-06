require 'spec_helper'

describe OrderTransaction do
  it "has a valid factory" do
    pending 'Bug'
    FactoryGirl.create(:order_transactions).should be_valid
  end
end
