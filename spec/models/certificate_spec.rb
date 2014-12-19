require 'spec_helper'

describe Certificate do
  it 'has a valid factory' do
    FactoryGirl.create(:certificate).should be_valid
  end
  it 'is invalid with blank name' do
    FactoryGirl.build(:certificate, name: '').should_not be_valid
  end
  it 'is invalid with nil name' do
    FactoryGirl.build(:certificate, name: nil).should_not be_valid
  end
end
