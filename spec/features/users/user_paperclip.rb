require 'spec_helper'

describe 'User Avatar' do

  before(:all) do
    I18n.locale = :en
  end

  it "should have a default image"
  it "should allow an image upload"
  it "should see the image on users#show"
  it "should see the image on teachers#show"
  it "should see the image on teachers#index"
  it "should see the image on courses#show"
end
