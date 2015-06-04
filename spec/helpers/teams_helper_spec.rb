require 'spec_helper'

describe TeamsHelper do
  include Devise::TestHelpers
  extend ControllerMacros

  context ':new_layout?' do
    it 'test of in new layout mode ' do
      @resource = FactoryGirl.create(:team)
      assign(:resource, @resource)
      expect(helper.new_layout?).to eql(true)
    end
    it 'expects a non teacher to not be a teacher' do
      expect(helper.new_layout?).to eql(false)
    end
  end
  context ':editable?' do
    it 'not logged in' do
      assign(:resource, FactoryGirl.create(:mentor))
      expect(helper.editable?).to eql(false)
    end
  end
  context ':editable_string?' do
    login_user

    it 'logged in as user' do
      assign(:resource, Mentor.find(current_user.id))

      expect(helper.editable_string?).to eql(true.to_s)
    end
    it 'not logged in as user' do
      @resource = FactoryGirl.create(:mentor)
      assign(:resource, @resource)

      expect(helper.editable_string?).to eql(false.to_s)
    end
  end
end
