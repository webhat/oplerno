module UsersHelper
	def is_teacher?
		unless @user.nil?
			@user.is_teacher?
		end
	end
end
