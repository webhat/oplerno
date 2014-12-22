class CourseRanking < ActiveRecord::Base
  belongs_to :course
  attr_accessible :ranking

  def rank
    set_default_rank

    add_rank 10, :name
    add_rank 40, :description
    add_rank 20, :syllabus

    add_rank_hidden 10

    synchronize_rank
  end

  def add_rank_hidden rank
    unless self.course[:hidden]
      add_rank rank, :hidden
    else
      add_rank 0-rank, :hidden
    end
  end

  def add_rank rank, member
    @rank += rank unless course_member_status member
  end

  private

  def course_member_status member
    self.course[member].nil?
  end

  def synchronize_rank
    self.ranking = @rank
  end

  def set_default_rank
    @rank ||= 0
  end
end
