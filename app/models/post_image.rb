class PostImage < ActiveRecord::Base
  belongs_to :post

  attr_accessible :post_id, :image, :main_image
  mount_uploader :image, ImageUploader

  # best version
  def best_version(version = :thumb)
    version = version.to_sym if version.class != Symbol
    vname = image.versions.map{|k, v| k.to_sym }
    vsize = [145, 220, 340, 640]
    idx = vname.index(version)

    if image.send(version).width.to_i < (vsize[idx] - 40)
      vname[idx+1] ? image.send(vname[idx+1]) : image
    else
      image.send(version)
    end
  end

end
