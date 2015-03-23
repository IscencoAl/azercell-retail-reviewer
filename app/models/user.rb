class User < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable
  include Modules::Sortable

  default_scope do
    UserRole.unscoped do
      where.not(:role => UserRole.super_admin)
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable:, :registerable, :recoverable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  validates :name, :presence => true
  validates :surname, :presence => true
  validates :password, :confirmation => true
  validates :role, :presence => true
  validates :dealer_id, :presence => true, :if => :dealer?

  has_one :device, :class_name => 'UserDevice'

  has_many :shops
  has_many :reports

  belongs_to :role, :class_name => 'UserRole', :foreign_key => :user_role_id
  belongs_to :dealer

  scope :with_name, -> (name) { where("name ilike ?", "%#{name}%") }
  scope :with_surname, -> (surname) { where("surname ilike ?", "%#{surname}%") }
  scope :with_email, -> (email) { where("email ilike ?", "%#{email}%") }
  scope :with_role, -> (role) { where(:role => role) }
  scope :with_is_deleted, -> (is_deleted) { deleted unless is_deleted.blank? }

  scope :by_name, -> (dir) { order("name #{dir}") }
  scope :by_surname, -> (dir) { order("surname #{dir}") }
  scope :by_email, -> (dir) { order("email #{dir}") }
  scope :by_role, -> (dir) { joins(:role).order("user_roles.name #{dir}") }
  scope :by_subscription, -> (dir) { order("subscription #{dir}") }

  before_create :generate_api_key

  def role
    UserRole.unscoped{ super }
  end

  def admin?
    self.role == UserRole.admin
  end

  def simple_user?
    self.role == UserRole.user
  end

  def reviewer?
    self.role == UserRole.reviewer
  end

  def dealer?
    self.role == UserRole.dealer
  end

  def super_admin?
    UserRole.unscoped do
      self.role == UserRole.super_admin
    end
  end

  def full_name
    [name, surname].join(' ')
  end

  def full_name_was
    [name_was, surname_was].join(' ')
  end

  def valid_password?(password)
    user_pass = BCrypt::Password.new(self.encrypted_password)
    return user_pass == password
  end

  private

  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(:api_key => api_key)
  end

end