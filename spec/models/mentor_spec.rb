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
      expect(mentor.tags).to be_empty
    end
    it ':angellist_url fail' do
      expect(mentor.angellist_url).to be_nil
    end
    it ':angellist_url fail' do
      expected = 'http://localhost/'
      mentor.links = { angellist_url: { url: expected } }
      expect(mentor.angellist_url).to_not be_empty
      expect(mentor.angellist_url).to eq expected
    end
    it ':linkedin_url' do
      expect(mentor.linkedin_url).to be_nil
    end
    it ':linkedin_url fail' do
      expected = 'http://localhost/'
      mentor.links = { linkedin_url: { url: expected } }
      expect(mentor.linkedin_url).to_not be_empty
      expect(mentor.linkedin_url).to eq expected
    end
  end
end
