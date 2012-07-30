class User < ActiveRecord::Base
  has_many :posts

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :fullname, :address, :phone, :profile, :facebook, :twitter, :website, :agreement,
    :avatar, :cover, :provider, :uid

  attr_accessor :agreement

  validates :fullname, :presence => true
  validates :agreement, :presence => true, :on => :create

  mount_uploader :avatar, ImageUploader
  mount_uploader :cover, ImageUploader

# Class Method

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first ||
      User.where(["email = ? AND provide IS NULL AND uid IS NULL", auth.extra.raw_info.name]).try(:first)
    unless user
      user = User.create(
        fullname: auth.extra.raw_info.name,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: pwd,
        password_confirmation: pwd
      )
    else
      user.update_attributes(:provider => auth.provider, :uid => auth.uid)
    end

    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] # && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

# Instant Method
end
