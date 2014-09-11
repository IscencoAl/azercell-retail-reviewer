class ShopPhoto < ActiveRecord::Base
  mount_uploader :photo, PhotosUploader

  validates :shop, :presence => true

  belongs_to :shop
end
