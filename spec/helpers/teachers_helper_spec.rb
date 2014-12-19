require 'spec_helper'

describe TeachersHelper do
  context '#prefix' do
    it '@teachers set return "teachers"' do
      @teachers = []

      expect(prefix).to eq 'teachers'
    end
    it '@teachers not set return "teacher"' do
      expect(prefix).to eq 'teacher'
    end
  end
  context '#teacher_cache_id' do
    it 'should generate global id' do
      expect_any_instance_of(TeachersHelper).to receive(:cache_id).and_return('YYY')
      expect_any_instance_of(Devise::TestHelpers).to receive(:current_user).and_return(nil)

      teacher = FactoryGirl.create(:teacher)
      expect(teacher_cache_id teacher).to eq "teacher_YYY_#{teacher.id}"
    end
    it 'should generate user specific id' do
      user = FactoryGirl.create(:user)
      expect_any_instance_of(TeachersHelper).to receive(:cache_id).and_return('YYY')
      allow_any_instance_of(Devise::TestHelpers).to receive(:current_user).and_return(user)

      teacher = FactoryGirl.create(:teacher)
      expect(teacher_cache_id teacher).to eq "teacher_YYY_#{teacher.id}_#{user.id}"
    end
  end
end
