class Dealer < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable
  include Modules::Sortable

  validates :name,  :presence => true, :uniqueness => true

  has_many :shops

  scope :with_name, -> (name) { where("name ilike ?", "%#{name}%") }
  scope :with_contact_name, -> (contact_name) { where("contact_name ilike ?", "%#{contact_name}%") }
  scope :with_is_deleted, -> (is_deleted) { deleted unless is_deleted.blank? }

  scope :by_name, -> (dir) { order("name #{dir}") }
  scope :by_contact_name, -> (dir) { order("contact_name #{dir}") }
end
