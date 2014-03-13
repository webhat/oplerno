# {include:User}
# @abstract
# See #User
class Teacher < User
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/assets/:style/avatar.png",
										:url => "/system/users/avatars/:id_partition/:style/:basename.:extension"
	searchkick
	paginates_per 24
end
