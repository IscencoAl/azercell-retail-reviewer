class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, :to => :crud
    
    if user.admin?
      can [:create, :read, :update], City, :is_deleted => false
      can :destroy, City do |city|
        not city.is_deleted and city.shops.blank?
      end
      can [:restore, :restore_info], City, :is_deleted => true

      can :crud, Dealer, :is_deleted => false
      can :restore, Dealer, :is_deleted => true

      can :crud, Employee, :is_deleted => false
      can :restore, Employee, :is_deleted => true

      can :crud, EmployeeWorkposition, :is_deleted => false
      can :restore, EmployeeWorkposition, :is_deleted => true

      can :crud, Item

      can [:create, :read, :update], Region, :is_deleted => false
      can :destroy, Region do |region|
        not region.is_deleted and region.cities.blank?
      end
      can :restore, Region, :is_deleted => true

      can :read, Report

      can :change, :report_structure

      can :crud, Shop, :is_deleted => false
      can [:restore, :restore_info], Shop, :is_deleted => true
      can [:info, :map_info], Shop
      can [:items, :new_item, :create_item, :destroy_item], Shop
      can [:employees, :new_employee, :create_employee, :edit_employee, :update_employee, :destroy_employee], Shop

      can [:create, :read, :update], ShopType, :is_deleted => false
      can :destroy, ShopType do |type|
        not type.is_deleted and type.shops.blank?
      end
      can :restore, ShopType, :is_deleted => true

      can :crud, ShopItem

      can :crud, User, :is_deleted => false
      can :restore, User, :is_deleted => true
      can :dashboard, User
      cannot :read, user

      can :manage, UserRole
    end

    if user.simple_user?
      can :read, City

      can :read, Dealer

      can :crud, Employee, :is_deleted => false
      can :restore, Employee, :is_deleted => true

      can :read, Region

      can :read, Report

      can [:read, :info, :map_info], Shop
      can [:items, :new_item, :create_item, :destroy_item], Shop
      can [:employees, :new_employee, :create_employee, :edit_employee, :update_employee, :destroy_employee], Shop

      can :crud, ShopItem

      can :update, user
      can :dashboard, User
      can :read, User
    end

    if user.reviewer?
      can :read, City

      can :read, Dealer

      can :read, Region

      can :read, Report, :user_id => user.id

      can :read, Shop, :user_id => user.id
      can [:index, :info, :map_info], Shop
      can [:items, :new_item, :create_item, :destroy_item], Shop, :user_id => user.id
      can [:employees, :new_employee, :create_employee, :edit_employee, :update_employee, :destroy_employee], Shop, :user_id => user.id

      can :update, user
      can :dashboard, user
      can :read, user
    end

    if user.dealer?
      can :read, user.dealer

      can :crud, Employee, :shop => { :dealer_id => user.dealer_id }
      can :restore, Employee, :shop => { :dealer_id => user.dealer_id }

      can :read, Report, :shop => { :dealer_id => user.dealer_id }

      can :read, Shop, :dealer_id => user.dealer_id
      can :info, Shop, :dealer_id => user.dealer_id
      can [:items, :new_item, :create_item, :destroy_item], Shop, :dealer_id => user.dealer_id
      can [:employees, :new_employee, :create_employee, :edit_employee, :update_employee, :destroy_employee], Shop, :dealer_id => user.dealer_id

      can :crud, ShopItem, :shop => { :dealer_id => user.dealer_id }
    end

  end
end
