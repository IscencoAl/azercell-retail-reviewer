class UserRole < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :users

  def self.admin
    find_by_name('admin')
  end

  def self.user
    find_by_name('user')
  end

  def self.reviewer
    find_by_name('reviewer')
  end

  def self.dealer
    find_by_name('dealer')
  end
end
