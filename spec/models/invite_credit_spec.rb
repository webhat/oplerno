require 'spec_helper'

describe InviteCredit do
  it ':amount' do
    expect(described_class.create!.amount).to eq 50
  end
  it ':used' do
    expect(described_class.create!.used).to eq false
  end
  it ':user' do
    expect(described_class.create!.user).to be_nil
  end
end
