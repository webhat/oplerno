
require 'spec_helper'

describe UsersHelper do
	it "expects a non teacher to not be a teacher" do
		@user = FactoryGirl.build(:user, email: 'testfaculty@oplerno.com')
		assign(:user, @user)
		expect(helper.is_teacher?).to eql(true)
	end
	it "expects a non teacher to not be a teacher" do
		@user = FactoryGirl.create(:user)
		assign(:user, @user)
		expect(helper.is_teacher?).to eql(false)
	end
end
