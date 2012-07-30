class Like < ActiveRecord::Base
  belongs_to :post

  attr_accessible :post_id, :user_id, :ip_address
  validates :user_id, :uniqueness => {:scope => :post_id}
  validates :ip_address, :uniqueness => {:scope => [:post_id, :user_id]}
end
