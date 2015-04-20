require 'spec_helper'

describe Invite do
  it ':active' do
    expect(described_class.create!.active).to be_nil
  end
  it ':code' do
    expect(described_class.create!.code).to_not be_nil
  end
  it ':user' do
    expect(described_class.create!.user).to be_nil
  end
end
