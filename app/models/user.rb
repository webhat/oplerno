class User < Parent
  include Ripple::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authy_authenticatable #, :validatable

  #, :confirmable # enabling with ripple causes an infinite loop

  #attr_accessible :email, :username

  validates_presence_of :email, :encrypted_password

  property :title, :type => String
  property :first_name, :type => String
  property :last_name, :type => String
  property :email, :type => String, :presence => true
  property :username, :type => String
  property :description, :type => String
  property :hidden, :type => Integer, :default => 0

  property :authy_id, :type => String
  property :authy_enabled, :type => Integer, :default => "0", :presence => true
  property :encrypted_password, :type => String, :default => "", :presence => true

  property :current_sign_in_at, :type => String
  property :last_sign_in_at, :type => String
  property :current_sign_in_ip, :type => String
  property :last_sign_in_ip, :type => String
  property :sign_in_count, :type => String
  #  property :confirmed_at, :type => String
  #  property :confirmation_token, :type => String
  #  property :confirmation_sent_at, :type => String
  property :remember_created_at, :type => String
  property :filename, :type => String
  property :content_type, :type => String
  property :binary_data, :type => String

  def picture=(input_data)
    self.filename = input_data.original_filename
    self.content_type = input_data.content_type.chomp
    self.binary_data = Base64.encode64(input_data.read)
  end

  alias :id :key

  def key
    Digest::MD5.hexdigest email
  end

  def update(updated_user)
    p updated_user
  end

  def destroy
    self.hidden = 1
  end

  def self.find_by_email(_email)
    User.find(Digest::MD5.hexdigest _email)
  end

  def self.find_by_id(id)
    User.find(id)
  end
end
