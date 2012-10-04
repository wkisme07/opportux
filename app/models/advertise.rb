class Advertise < ActiveRecord::Base
  attr_accessible :business_name, :contact_name, :contact_email, :size, :title, :url, :description, :image, :price, :viewed
  mount_uploader :image, AdvUploader

  validates :business_name, :contact_name, :contact_email, :size, :title, :url, :description, :image, :price, :presence => true

  before_save :complete_url

  def complete_url
    self.url = "http://#{self.url}" unless self.url.include?('http://')
  end

  # big
  def self.big
    adv = where(["size = ?", 'big']).offset(rand(size_count('big'))).try(:first)
    if adv
      adv.update_attribute(:viewed, adv.viewed + 1)
      adv
    end
    adv
  end

  # medium
  def self.medium
    off = rand(size_count('medium'))
    advs = where(["size = ?", 'medium']).offset(off == 0 ? off : off-1).slice(0, 2)
    add_viewed(advs)

    advs
  end

  # small
  def self.small
    sc = size_count('small')
    r = rand(sc)
    off = sc != 0 && (sc - r) > 4 ? sc - 4 : r

    advs = where(["size = ?", 'small']).offset(off).slice(0, 4)
    add_viewed(advs)

    advs
  end

  # adv type count
  def self.size_count(s)
    where(["size = ?", s]).count
  end

  # Add viewed counter
  def self.add_viewed(advs)
    update_all(["viewed = (viewed + 1)"], ["id IN (?)", advs.map(&:id)]) unless advs.blank?
  end

  # adv invoice
  def self.invoice
    all.each do |adv|
      MailerWorker.perform_async(send_advertise_invoice, adv.id, adv.viewed, adv.month_price)
      adv.update_attribute(:viewed, 0)
    end
  end

  def month_price
    viewed * price
  end

end
