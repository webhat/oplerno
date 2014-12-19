# Handles the User and ensures that it is linked to Canvas by way of a #CanvasUsers
# #Student and #Teacher are aliases for this class
class User < ActiveRecord::Base
  extend EncryptedAttributes
  extend VirtualAttributes
  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :path => "users/:attachment/:id_partition/:style/:filename",
    :url => "/dynamic/users/avatars/:id_partition/:style/:basename.:extension",
    :default_url => "/assets/:style/avatar.png", :storage => :redis

  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }
  validates_uniqueness_of :email

  has_paper_trail
  acts_as_paranoid

  encrypt_with_public_key :secret,
    :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')
  encrypt_with_public_key :title,
    :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')
  encrypt_with_public_key :first_name,
    :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')
  encrypt_with_public_key :last_name,
    :key_pair => Rails.root.join('config', 'strongbox', 'keypair.pem')

  create_encrypted_attributes :last_name, :first_name, :title

  create_virtual_attributes :links
  validates_with UserValidator, fields: [:links]
  attr_accessible :links
  serialize :links

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :authy_authenticatable,
    :confirmable, :lockable # enabling with ripple causes an infinite loop
  #, :validatable

  validates_presence_of :email, :encrypted_password

  validates :password, presence: true, length: {minimum: 8}, on: :create
  validates :password_confirmation, presence: true, on: :create

  #  after_commit CanvasUsers

  attr_accessible :title,
    :first_name,
    :last_name,
    :email, :privateemail, :mailpass,
    :username,
    :description,
    :hidden,
    #:authy_id,
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
    :binary_data,
    :encrypted_title, :encrypted_last_name, :encrypted_first_name

  has_and_belongs_to_many :courses
  has_one :cart
  has_many :orders
  has_one :canvas_users

  def self.find_by_id(id)
    User.find(id)
  end

  def is_teacher?
    self.email[-11..-1] == 'oplerno.com' 
  end

  def display_name
    begin
      "#{self.encrypted_first_name.force_encoding("binary")} #{self.encrypted_last_name.force_encoding("binary")}"
    rescue
      "Unknown"
    end
  end

  # Store the mail password in memory plaintext while the invitation mail is being generated
  #
  def mailpass= pass
    @pass = pass
  end

  # Retrieve the mail password from memory plaintext for the invitation mail
  #
  def mailpass
    @pass
  end
end
