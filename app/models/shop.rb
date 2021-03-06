class Shop < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable
  include Modules::Sortable

  belongs_to :type,   :class_name => 'ShopType', :foreign_key => 'shop_type_id'
  belongs_to :city,   touch: true
  belongs_to :dealer, touch: true
  belongs_to :user,   -> { where(:role => UserRole.reviewer) }

  has_one :region, :through => :city

  has_many :photos,     :class_name => 'ShopPhoto'
  has_many :shop_items
  has_many :employees
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
  scope :with_region, -> (region) { joins(:city).where(:cities => {:region_id => region}) }

  scope :by_type, -> (dir) { joins(:type).order("shop_types.name #{dir}") }
  scope :by_dealer, -> (dir) { joins(:dealer).order("dealers.name #{dir}") }
  scope :by_user, -> (dir) { includes(:user).order("users.name #{dir} nulls last") }
  scope :by_address, -> (dir) { joins(:city).order("cities.name #{dir}, address #{dir}") }
  scope :by_score, -> (dir) { order("score #{dir} nulls last")}

  before_soft_delete :delete_shop_items, :delete_employees

  def name
    City.unscoped do
      [city.name, address].join(', ')
    end
  end

  def name_was
    City.unscoped do
      city_was = Shop.with_deleted.find(self.id).city
      [city_was.name, address_was].join(', ')
    end
  end

  def last_report
    reports.order('created_at desc').first
  end

  def self.not_reviewed(date)
    last_reports = Report.select("distinct on(shop_id) shop_id, created_at").order("shop_id, created_at desc").to_sql
    return Shop.joins("left outer join (#{last_reports}) as reports on reports.shop_id = shops.id").where("reports.created_at < ? or reports.created_at is null", date)
  end

  private

  def delete_shop_items
    shop_items.each do |item|
      item.destroy
    end
  end

  def delete_employees
    employees.each do |employee|
      employee.soft_delete
    end
  end
end
