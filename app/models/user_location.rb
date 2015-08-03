class UserLocation < ActiveRecord::Base
  include Modules::Filterable

  belongs_to :user

  scope :with_user, -> (user) { where(:user => user) }
  scope :with_created_at_from, -> (from) { where('created_at >= ?', from) }
  scope :with_created_at_to, -> (to) { where('created_at <= ?', to) }
end