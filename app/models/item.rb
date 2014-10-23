class Item < ActiveRecord::Base
  include Modules::Filterable
  include Modules::Sortable

  validates :name, :presence => true, :uniqueness => true

  has_many :shop_items, :dependent => :destroy

  scope :with_name, -> (name) { where("name ilike ?", "%#{name}%") }
  scope :with_is_deleted, -> (is_deleted) { deleted unless is_deleted.blank? }

  scope :by_name, -> (dir) { order("name #{dir}") }
end
