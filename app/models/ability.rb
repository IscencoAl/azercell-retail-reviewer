class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, :to => :crud
    
    if user.admin?
      can :crud, City, :is_deleted => false
      can :restore, City, :is_deleted => true

      can :crud, Dealer, :is_deleted => false
      can :restore, Dealer, :is_deleted => true

      can :crud, Region, :is_deleted => false
      can :restore, Region, :is_deleted => true

      can :read, Report

      can :change, :report_structure

      can :crud, Shop, :is_deleted => false
      can :restore, Shop, :is_deleted => true

      can :crud, ShopType, :is_deleted => false
      can :restore, ShopType, :is_deleted => true

      can :crud, User, :is_deleted => false
      can :restore, User, :is_deleted => true

      can :manage, UserRole
    end

    if user.simple_user?
      can :read, City

      can :read, Dealer

      can :read, Region

      can :read, Report

      can :read, Shop

      can :update, User, :id => user.id
      can :read, User
    end

    if user.reviewer?
      can :read, City

      can :read, Dealer

      can :read, Region

      can :read, Report, :user_id => user.id

      can :read, Shop

      can :update, User, :id => user.id
      can :read, User
    end

  end
end
