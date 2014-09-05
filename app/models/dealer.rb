class Dealer < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable

  validates :name,  :presence => true, :uniqueness => true

  scope :with_name, -> (name) { where("name ilike ?", "%#{name}%") }
  scope :with_contact_name, -> (contact_name) { where("contact_name ilike ?", "%#{contact_name}%") }
  scope :with_email, -> (email) { where("email ilike ?", "%#{email}%") }
  scope :with_phone_number, -> (phone_number) { where("phone_number ilike ?", "%#{phone_number}%") }
  scope :with_is_deleted, -> (is_deleted) { deleted unless is_deleted.blank? }
end
