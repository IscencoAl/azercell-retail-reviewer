class Shop < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable
  include Modules::Sortable

  belongs_to :type, :class_name => 'ShopType', :foreign_key => 'shop_type_id'
  belongs_to :city
  belongs_to :dealer
  belongs_to :user, -> { where(:role => UserRole.reviewer) }

  has_one :region, :through => :city

  has_many :photos, :class_name => 'ShopPhoto', :dependent => :destroy
  has_many :reports

  validates :type,  :presence => true
  validates :city,  :presence => true
  validates :dealer,  :presence => true
  validates :user,  :presence => true
  validates :address,  :presence => true

  scope :with_type, -> (type) { where(:type => type) }
  scope :with_city, -> (city) { where(:city => city) }
  scope :with_dealer, -> (dealer) { where(:dealer => dealer) }
  scope :with_user, -> (user) { where(:user => user) }
  scope :with_address, -> (address) { where("address ilike ?", "%#{address}%") }
  scope :with_is_deleted, -> (is_deleted) { deleted unless is_deleted.blank? }

  scope :by_type, -> (dir) { joins(:type).order("shop_types.name #{dir}") }
  scope :by_dealer, -> (dir) { joins(:dealer).order("dealers.name #{dir}") }
  scope :by_user, -> (dir) { joins(:user).order("users.name #{dir}") }
  scope :by_address, -> (dir) { joins(:city).order("cities.name #{dir}, address #{dir}") }
  scope :by_score, -> (dir) { order("score #{dir} nulls last")}

  def full_address
    City.unscoped do
      [city.name, address].join(', ')
    end
  end

  def full_address_was
    City.unscoped do
      city_was = Shop.with_deleted.find(self.id).city
      [city_was.name, address_was].join(', ')
    end
  end

  def last_report
    reports.order('created_at desc').first
  end
end
