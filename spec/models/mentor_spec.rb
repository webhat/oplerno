require 'spec_helper'

describe Mentor do
  context 'factories' do
    it '#create' do
      mentor = FactoryGirl.create(:mentor)
      expect(mentor).to_not be_nil
    end
  end

  it ':tags' do
    mentor = FactoryGirl.create(:mentor)
    tags = mentor.tags
    expect(tags).to be_kind_of(Array)
    expect(tags).to_not be_empty
  end
end
