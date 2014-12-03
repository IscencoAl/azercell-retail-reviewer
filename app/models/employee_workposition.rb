class EmployeeWorkposition < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable

  validates :name, :presence => true, :uniqueness => true

  has_many :employees

  scope :with_name, -> (name) { where("name ilike ?", "%#{name}%") }
  scope :with_is_deleted, -> (is_deleted) { deleted unless is_deleted.blank? }
end
