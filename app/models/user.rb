class User < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable:, registerable, :recoverable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  validates :name, :presence => true
  validates :surname, :presence => true
  validates :password, :confirmation => true
  validates :role, :presence => true

  belongs_to :role, :class_name => 'UserRole', :foreign_key => :user_role_id

  scope :with_name, -> (name) { where("name ilike ?", "%#{name}%") }
  scope :with_surname, -> (surname) { where("surname ilike ?", "%#{surname}%") }
  scope :with_email, -> (email) { where("email ilike ?", "%#{email}%") }
  scope :with_role, -> (role) { where(:role => role) }
  scope :with_is_deleted, -> (is_deleted) { deleted unless is_deleted.blank? }

  def admin?
    self.role == UserRole.admin
  end

  def simple_user?
    self.role == UserRole.user
  end

  def full_name
    [name, surname].join(' ')
  end

  def full_name_was
    [name_was, surname_was].join(' ')
  end

end