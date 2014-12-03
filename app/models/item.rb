class Item < ActiveRecord::Base
  include Modules::Filterable
  include Modules::Sortable

  validates :name, :presence => true, :uniqueness => true

  has_many :shop_items, :dependent => :destroy

  scope :with_name, -> (name) { where('name ilike ?', "%#{name}%") }

  scope :by_name, -> (dir) { order("name #{dir}") }
end
