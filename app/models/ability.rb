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

      can :read, :dashboard

      can :crud, Dealer, :is_deleted => false
      can :restore, Dealer, :is_deleted => true

      can :crud, Employee, :is_deleted => false
      can :restore, Employee, :is_deleted => true

      can :crud, EmployeeWorkposition, :is_deleted => false
      can :restore, EmployeeWorkposition, :is_deleted => true

      can :crud, Item, :is_deleted => false
      can :restore, Item, :is_deleted => true

      can [:create, :read, :update], Region, :is_deleted => false
      can :destroy, Region do |region|
        not region.is_deleted and region.cities.blank?
      end
      can :restore, Region, :is_deleted => true

      can :read, Report

      can :change, :report_structure

      can :crud, Shop, :is_deleted => false
      can [:restore, :restore_info], Shop, :is_deleted => true
      can :info, Shop
      can :map_info, Shop

      can [:create, :read, :update], ShopType, :is_deleted => false
      can :destroy, ShopType do |type|
        not type.is_deleted and type.shops.blank?
      end
      can :restore, ShopType, :is_deleted => true

      can :crud, ShopItem

      can :crud, User, :is_deleted => false
      can :restore, User, :is_deleted => true

      can :manage, UserRole
    end

    if user.simple_user?
      can :read, City

      can :read, Dealer

      can :crud, Employee, :is_deleted => false
      can :restore, Employee, :is_deleted => true

      can :read, Region

      can :read, Report

      can :read, Shop
      can :info, Shop
      can :map_info, Shop

      can :crud, ShopItem

      can :update, User, :id => user.id
      can :read, User
    end

    if user.reviewer?
      can :read, City

      can :read, Dealer

      can :crud, Employee, :shop => { :user_id => user.id }
      can :restore, Employee, :shop => { :user_id => user.id }

      can :read, Region

      can :read, Report, :user_id => user.id

      can :read, Shop, :user_id => user.id
      can :info, Shop, :user_id => user.id
      can :map_info, Shop

      can :crud, ShopItem, :shop => { :user_id => user.id }

      can :update, User, :id => user.id
      can :read, User, :id => user.id
    end

    if user.dealer?
      can :read, user.dealer

      can :crud, Employee, :shop => { :dealer_id => user.dealer_id }
      can :restore, Employee, :shop => { :dealer_id => user.dealer_id }

      can :read, Report, :shop => { :dealer_id => user.dealer_id }

      can :read, Shop, :dealer_id => user.dealer_id
      can :info, Shop, :dealer_id => user.dealer_id

      can :crud, ShopItem, :shop => { :dealer_id => user.dealer_id }
    end

  end
end
