require 'spec_helper'
RSpec.describe TeacherRankingWorker, :type => :worker do
	it 'should update TeacherRanking' do
		user = FactoryGirl.build(:user, email: 'teacher_ranking_worker@oplerno.com')

		User.observers.enable :user_observer do
			user.save
		end

		teacher_ranking = Teacher::find(user.id).rank

		teacher_ranking.should_not be_nil
	end
end
