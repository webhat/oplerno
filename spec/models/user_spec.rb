# spec/models/user.rb
require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end
  it "is invalid without a email" do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end
  it "is invalid without a password" do
    expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
  end

  describe 'Strongbox' do
    it 'encrypts secret' do
      user = FactoryGirl.create(:user)
      value = 'Ssssh'
      user.secret = value
      expect(user.secret.decrypt Devise.secret_key).to eq value
    end
    it 'encrypts secret' do
      user = FactoryGirl.create(:user)
      value = 'Ssssh'
      user.title = value
      expect(user.title).not_to eq value
      expect(user.title.decrypt Devise.secret_key).to eq value
    end
    it 'encrypts secret' do
      user = FactoryGirl.create(:user)
      value = 'Ssssh'
      user.first_name = value
      expect(user.first_name).not_to eq value
      expect(user.first_name.decrypt Devise.secret_key).to eq value
    end
    it 'encrypts secret' do
      user = FactoryGirl.create(:user)
      value = 'Ssssh'
      user.last_name = value
      expect(user.last_name).not_to eq value
      expect(user.last_name.decrypt Devise.secret_key).to eq value
    end
  end
end
