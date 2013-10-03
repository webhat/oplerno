class User
  include Ripple::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #, :validatable

  property :username, String
  property :password, String
  property :email, String, :presence => true

  def validates_uniqueness_of
    false
  end
end
