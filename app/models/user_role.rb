class UserRole < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
end
