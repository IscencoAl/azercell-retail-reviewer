class ShopItem < ActiveRecord::Base
  include Modules::Filterable
  include Modules::Sortable
  
  validates :item, :presence => true, :uniqueness => {:scope => :shop}
  validates :shop, :presence => true

  belongs_to :item
  belongs_to :shop

  has_one :city, :through => :shop

  scope :with_item, -> (item) { where(:item => item) }
  scope :with_shop, -> (shop) { where(:shop => shop) }

  scope :by_item, -> (dir) { joins(:item).order("items.name #{dir}") }
  scope :by_shop, -> (dir) { joins(:city).order("cities.name #{dir}, shops.address #{dir}") }

  def missing_items
    shop = self.shop

    return Item.all unless shop

    existing_items_id = shop.shop_items.select(:item_id)
    Item.where("id not in (?)", existing_items_id)
  end
end
