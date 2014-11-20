class TeacherRanking < ActiveRecord::Base
  attr_accessible :ranking
	#has_paper_trail

	belongs_to :teacher

	before_save :synchronize_rank

	def rank
		set_default_rank

		add_rank 10, :first_name
		add_rank 10, :last_name
		add_rank 5, :title
		add_rank 30, :avatar
#		add_rank 10, :last_sign_in_at
		add_rank self.teacher[:sign_in_count]/10, :sign_in_count
		add_rank 40, :description

		synchronize_rank
	end

	def add_rank rank, member
		@rank += rank unless self.teacher[member].nil?
	end

	private

	def synchronize_rank
		self.ranking = @rank
	end

	def set_default_rank
		@rank ||= 0
	end
end
