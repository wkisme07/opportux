class City < ActiveRecord::Base
  has_many :posts

  attr_accessible :country_id, :region_id, 
    :name, :latitude, :longitude, :timezone, :dma_id, :county, :code

end
