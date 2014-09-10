class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, :to => :crud
    
    if user.admin?
      can :crud, Dealer, :is_deleted => false
      can :restore, Dealer, :is_deleted => true
      can :crud, User, :is_deleted => false
      can :restore, User, :is_deleted => true

      can :manage, UserRole

      can :crud, City, :is_deleted => false
      can :restore, City, :is_deleted => true

      can :crud, Shop, :is_deleted => false
      can :restore, Shop, :is_deleted => true

      can :crud, ShopType, :is_deleted => false
      can :restore, ShopType, :is_deleted => true


      can :crud, Region, :is_deleted => false
      can :restore, Region, :is_deleted => true
    end

    if user.simple_user?
      can :read, Dealer
      can :update, User, :id => user.id
      can :read, User

      can :read, City
      
      can :read, Shop
      can :read, Region
    end

  end
end
