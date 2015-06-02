require 'spec_helper'

describe Mentor do
  let(:mentor) { create :mentor }
  context 'factories' do
    it '#create' do
      expect(mentor).to_not be_nil
    end
  end

  context 'methods' do
    it ':tags' do
      tags = mentor.tags
      expect(tags).to be_kind_of(Array)
      expect(tags).to_not be_empty
    end
    it ':angellist_url fail' do
      url = mentor.angellist_url
      expect(url).to be_nil
    end
    it ':angellist_url fail' do
      expected = 'http://localhost/'
      mentor.links = { angellist_url: { url: expected } }
      url = mentor.angellist_url
      expect(url).to_not be_empty
      expect(url).to eq expected
    end
    it ':linkedin_url' do
      url = mentor.linkedin_url
      expect(url).to be_nil
    end
    it ':linkedin_url fail' do
      expected = 'http://localhost/'
      mentor.links = { linkedin_url: { url: expected } }
      url = mentor.linkedin_url
      expect(url).to_not be_empty
      expect(url).to eq expected
    end
  end
end
