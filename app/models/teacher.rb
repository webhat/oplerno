# {include:User}
# @abstract
# See #User
class Teacher < User
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :default_url => "/assets/:style/avatar.png",
    :path => "users/:attachment/:id_partition/:style/:filename",
    :url => "/dynamic/users/avatars/:id_partition/:style/:basename.:extension",
    :storage => :redis
  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }

  searchkick
  paginates_per 24

  has_one :rank, class_name: 'TeacherRanking'
  has_one :podio_teacher
  has_many :certificates

  def self.all(*args)
    find(:all, *args, conditions: [ "email like ?", "%oplerno.com"])
  end
end
