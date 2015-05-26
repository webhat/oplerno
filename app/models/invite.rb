class Invite < ActiveRecord::Base
  belongs_to :user
  attr_accessible :active, :code, :user, :user_id

  after_initialize :set_code

  def user_id= id
    self.user = User.find(id)
  end

  def set_code
    self.code ||= Digest::SHA256.hexdigest(Time.now.to_s)[0..10]
  end
end
