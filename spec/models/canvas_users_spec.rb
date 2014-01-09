require 'spec_helper'

describe CanvasUsers do
  it "has a valid factory" do
    FactoryGirl.create(:canvas_user).should be_valid
  end
  it "is valid with a student" do
    FactoryGirl.build(:canvas_user, user: FactoryGirl.create(:student)).should be_valid
  end
end
