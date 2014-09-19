class Shop < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable
  include Modules::Sortable

  belongs_to :type, :class_name => 'ShopType', :foreign_key => 'shop_type_id'
  belongs_to :city
  belongs_to :dealer
  belongs_to :user

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

  def full_address
    [city.name, address].join(', ')
  end

  def full_address_was
    [city.name_was, address_was].join(', ')
  end

  def score
    return last_report.score if last_report
  end

  def last_report
    reports.order('created_at desc').first
  end
end
