class City < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable
  include Modules::Sortable

  validates :name,  :presence => true, :uniqueness => true
  validates :region,  :presence => true

  belongs_to :region

  scope :with_name, -> (name) { where("name ilike ?", "%#{name}%") }
  scope :with_region, -> (region) { where(:region => region) }
  scope :with_is_deleted, -> (is_deleted) { deleted unless is_deleted.blank? }

  scope :by_name, -> (dir) { order("name #{dir}") }
  scope :by_region, -> (dir) { joins(:region).order("regions.name #{dir}") }
end
