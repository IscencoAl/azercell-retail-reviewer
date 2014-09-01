class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable:, registerable, :recoverable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  include Modules::SoftDelete

  validates :name, :presence => true
  validates :surname, :presence => true

  belongs_to :role, :class_name => 'UserRole', :foreign_key => :user_role_id

  def full_name
    [name_was, surname_was].join(' ')
  end

end