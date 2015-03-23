class UserRole < ActiveRecord::Base
  default_scope { where.not(:name => SUPER_ADMIN) }
  
  validates :name, :presence => true, :uniqueness => true

  has_many :users

  ADMIN = 'admin'
  USER = 'user'
  REVIEWER = 'reviewer'
  DEALER = 'dealer'
  SUPER_ADMIN = 'super_admin'

  def self.admin
    find_by_name(ADMIN)
  end

  def self.user
    find_by_name(USER)
  end

  def self.reviewer
    find_by_name(REVIEWER)
  end

  def self.dealer
    find_by_name(DEALER)
  end

  def self.super_admin
    find_by_name(SUPER_ADMIN)
  end
end
