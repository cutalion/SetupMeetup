require 'password_generator'

class User
  include Mongoid::Document
  include PasswordGenerator

  has_many :authorizations, dependent: :destroy
  has_many :owned_events, foreign_key: :owner_id, class_name: "Event"
  has_and_belongs_to_many :events

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :name

  validates_uniqueness_of :name

  def self.find_or_create_with_oauth(oauth_data, signed_in_resource=nil)
    user = find_with_oauth(oauth_data) || create_with_oauth(oauth_data)
    user.connect_with_provider!(oauth_data)
    user
  end


  def self.find_with_oauth(oauth_data)
    user = find_by_email oauth_data.info.email if oauth_data.info.email.present?
    user || find_through_authorization(oauth_data)
  end


  def self.find_through_authorization(oauth_data)
    authorization = Authorization.find_by_provider_and_uid(oauth_data.provider, oauth_data.uid)
    authorization && authorization.user
  end


  def self.create_with_oauth(oauth_data)
    password = SecureRandom.base64(6)
    user = User.new(
      :email                 => oauth_data.info.email,
      :password              => password,
      :password_confirmation => password
    )
    user.name = oauth_data.info.name unless User.where(name: name).exists?
    user.email_not_required!
    user.save!
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if session["devise.oauth_data"] && session["devise.oauth_data"]["info"]
        user.email = session["devise.oauth_data"]["info"]["email"]
      end
    end
  end

  def self.find_by_email(email)
    where(email: email).first
  end

  def connect_with_provider!(oauth_data)
    unless authorizations.where(:provider => oauth_data.provider, :uid => oauth_data.uid).any?
      authorizations.create!(:provider => oauth_data.provider, :uid => oauth_data.uid, :token => oauth_data.credentials.token)
    end
  end

  def name
    username= read_attribute(:name)
    username.blank? ? "User#{id}" : username
  end

  def email_not_required!
    @skip_email_presence_validation = true
  end

  def email_required?
    !@skip_email_presence_validation
  end
end
