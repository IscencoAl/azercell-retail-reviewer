class Employee < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable
  include Modules::Sortable

  validates :name, :presence => true, :uniqueness => true
  validates :shop, :presence => true
  validates :employee_workposition, :presence => true

  belongs_to :shop
  belongs_to :employee_workposition
  has_one :city, :through => :shop

  scope :with_name, -> (name) { where("name ilike ?", "%#{name}%") }
  scope :with_is_deleted, -> (is_deleted) { deleted unless is_deleted.blank? }
  scope :with_shop, -> (shop) { where(:shop => shop) }
  scope :with_employee_workposition, -> (employee_workposition) { where(:employee_workposition => employee_workposition) }

  scope :by_name, -> (dir) { order("name #{dir}") }
  scope :by_shop, -> (dir) { joins(:city).order("cities.name #{dir}, shops.address #{dir}") }
  scope :by_employee_workposition, -> (dir) { joins(:employee_workposition).order("employee_workpositions.name #{dir}") }
end
