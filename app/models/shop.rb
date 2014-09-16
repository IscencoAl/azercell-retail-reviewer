class Shop < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable
  include Modules::Sortable

  belongs_to :shop_type
  belongs_to :city
  belongs_to :dealer
  belongs_to :user

  has_many :photos, :class_name => 'ShopPhoto', :dependent => :destroy
  has_many :reports

  validates :shop_type,  :presence => true
  validates :city,  :presence => true
  validates :dealer,  :presence => true
  validates :user,  :presence => true
  validates :address,  :presence => true

  scope :with_shop_type, -> (shop_type) { where(:shop_type => shop_type) }
  scope :with_city, -> (city) { where(:city => city) }
  scope :with_dealer, -> (dealer) { where(:dealer => dealer) }
  scope :with_user, -> (user) { where(:user => user) }
  scope :with_address, -> (address) { where("address ilike ?", "%#{address}%") }
  scope :with_is_deleted, -> (is_deleted) { deleted unless is_deleted.blank? }

  scope :by_shop_type, -> (dir) { joins(:shop_type).order("shop_types.name #{dir}") }
  scope :by_dealer, -> (dir) { joins(:dealer).order("dealers.name #{dir}") }
  scope :by_user, -> (dir) { joins(:user).order("users.name #{dir}") }

  def full_address
    [city.name, address].join(' ')
  end

  def full_address_was
    [city.name_was, address_was].join(' ')
  end

end