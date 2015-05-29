require 'spec_helper'

describe Team do
  context 'factories' do
    it '#create' do
      t = FactoryGirl.create(:team)
      expect(t).to_not be_nil
    end
  end
  it '#create' do
    t = described_class.create!
    expect(t).to_not be_nil
  end
  it ':display_name' do
    t = FactoryGirl.build :team, name: 'Test'
    expect(t.display_name).to eq t.name
  end
  it ':tags' do
    t = FactoryGirl.build :team, name: 'Test'
    expect(t.tags).to be_kind_of(Array)
    expect(t.tags).to be_empty
  end
  it ':tags' do
    t = FactoryGirl.build :team, name: 'Test'
    t.mentors << FactoryGirl.create(:mentor)
    expect(t.tags).to be_kind_of(Array)
    expect(t.tags).to_not be_empty
  end
end
