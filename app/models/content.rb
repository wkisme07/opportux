class Content < ActiveRecord::Base
  attr_accessible :code, :title, :value
  validates :code, :title, :value, :presence => true
end
