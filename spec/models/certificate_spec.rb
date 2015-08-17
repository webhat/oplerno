require 'spec_helper'

describe Certificate do
  it 'has a valid factory' do
    expect( FactoryGirl.create(:certificate) ).to be_valid
  end
  it 'is invalid with blank name' do
    skip
    expect( FactoryGirl.build(:certificate, name: '') ).to be_valid
  end
  it 'is invalid with nil name' do
    expect( FactoryGirl.build(:certificate, name: nil) ).to_not be_valid
  end
end
