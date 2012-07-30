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

end
