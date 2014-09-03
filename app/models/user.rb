class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable:, registerable, :recoverable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  include Modules::SoftDelete

  validates :name, :presence => true
  validates :surname, :presence => true
  validates :password, :confirmation => true
  validates :role, :presence => true

  belongs_to :role, :class_name => 'UserRole', :foreign_key => :user_role_id

  def admin?
    self.role.name == "admin"
  end

  def simple_user?
    self.role.name == "user"
  end

  def full_name
    [name_was, surname_was].join(' ')
  end

end