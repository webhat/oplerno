require 'spec_helper'

describe TeamsHelper do
  it 'test of in new layout mode ' do
    @team = FactoryGirl.create(:team)
    assign(:team, @team)
    expect(helper.new_layout?).to eql(true)
  end
  it 'expects a non teacher to not be a teacher' do
    expect(helper.new_layout?).to eql(false)
  end
end
