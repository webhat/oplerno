require 'spec_helper'

describe TeacherRanking do
  before(:each) do
    @teacher = Teacher.create
  end

  it 'has a valid factory' do
    FactoryGirl.create(:teacher_ranking).should be_valid
  end

  it 'accepts a Teacher' do
    teacher_ranking = FactoryGirl.build(:teacher_ranking, {teacher: @teacher})
    teacher_ranking.save
    teacher_ranking.should be_valid
  end

  context 'Rank Elements' do
    before(:each) do
      @teacher = Teacher.create
      @teacher.build_rank ranking: 0
      @teacher.rank.teacher = @teacher
      @teacher.rank.save
      @teacher.save
    end
    it 'should rank first name' do
      @teacher.first_name = Faker::Name.first_name

      User.observers.enable :user_observer do
        @teacher.save
      end

      @teacher.rank.rank

      @teacher.rank.ranking.should eq 10
    end
    it 'should rank empty first name as 0' do
      @teacher.first_name = ''
      @teacher.save

      @teacher.rank.rank

      @teacher.rank.ranking.should eq 0
    end
    it 'should rank no first name as 0' do
      @teacher.first_name = nil
      @teacher.save

      @teacher.rank.rank

      @teacher.rank.ranking.should eq 0
    end
    it 'should rank last name' do
      @teacher.last_name = Faker::Name.last_name
      @teacher.save

      @teacher.rank.rank

      @teacher.rank.ranking.should eq 10
    end
    it 'should rank title' do
      @teacher.title = 'Dr'
      @teacher.save

      @teacher.rank.rank

      @teacher.rank.ranking.should eq 5
    end
    it 'should rank avatar' do
      pending 'Error accessing member teacher[:avatar]'
      @teacher.avatar = Rack::Test::UploadedFile.new(Rails.root + 'spec/files/test.jpg', 'image/jpg')
      @teacher.save

      @teacher.rank.rank

      @teacher.rank.ranking.should eq 30
    end

    it 'should rank last sign in' do
      pending 'Initial failure'
      @teacher.last_sign_in_at = Faker::Date.between(2.days.ago, Date.today)
      @teacher.save

      @teacher.rank.rank

      @teacher.rank.ranking.should eq 10
    end

    [0, 10, 20, 30, 40, 50, 80, 100, 200].each do |cnt|
      it "should rank last sign in count #{cnt}" do
        @teacher.sign_in_count = cnt
        @teacher.save

        @teacher.rank.rank

        @teacher.rank.ranking.should eq cnt/10
      end
    end

    it 'should rank description' do
      @teacher.description = Faker::Lorem.sentence(30)
      @teacher.save

      @teacher.rank.rank

      @teacher.rank.ranking.should eq 40
    end
  end
end
