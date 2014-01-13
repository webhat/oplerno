class User < ActiveRecord::Base

  encrypt_with_public_key :secret,
                          :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')
  encrypt_with_public_key :title,
                          :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')
  encrypt_with_public_key :first_name,
                          :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')
  encrypt_with_public_key :last_name,
                          :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authy_authenticatable,
         :confirmable, :lockable # enabling with ripple causes an infinite loop
  #, :validatable

  validates_presence_of :email, :encrypted_password

  validates :password, presence: true, length: {minimum: 8}, on: :create
  validates :password_confirmation, presence: true, on: :create

  attr_accessible :title,
                  :first_name,
                  :last_name,
                  :email,
                  :username,
                  :description,
                  :hidden,
                  :authy_id,
                  :authy_enabled,
                  :password,
                  :password_confirmation,
                  :encrypted_password,
                  :current_sign_in_at,
                  :last_sign_in_at,
                  :current_sign_in_ip,
                  :last_sign_in_ip,
                  :sign_in_count,
                  :confirmed_at,
                  :confirmation_token,
                  :confirmation_sent_at,
                  :remember_me,
                  :remember_created_at,
                  :filename,
                  :content_type,
                  :binary_data


  has_many :courses
  has_one :cart
  has_many :orders
  has_one :canvas_user

  def picture=(input_data)
    self.filename = input_data.original_filename
    self.content_type = input_data.content_type.chomp
    self.binary_data = Base64.encode64(input_data.read)
  end

  def key
    Digest::MD5.hexdigest email
  end

  def destroy
    self.hidden = 1
  end

  def self.find_by_id(id)
    User.find(id)
  end
end
