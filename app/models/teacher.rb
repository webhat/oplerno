# {include:User}
# @abstract
# See #User
class Teacher < User
	searchkick
	paginates_per 24
end
