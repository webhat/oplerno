# spec/models/user.rb
require 'spec_helper'

describe User do
  it "has a valid factory"                do
    FactoryGirl.create(:user).should be_valid
  end
  it "is invalid without a email"       do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end
  it "is invalid without a password"  do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end
  it "returns a contact's key as a hash" do
    user = FactoryGirl.create(:user)
    user.key.should eq Digest::MD5.hexdigest user.email
  end
end