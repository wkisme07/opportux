class Category < ActiveRecord::Base
  has_many :posts
  
  attr_accessible :code, :name
end
