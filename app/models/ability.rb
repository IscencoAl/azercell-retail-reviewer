class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, :to => :crud
    
    if user.admin?
      can :crud, City, :is_deleted => false
      can :restore, City, :is_deleted => true

      can :crud, Dealer, :is_deleted => false
      can :restore, Dealer, :is_deleted => true

      can :crud, Region, :is_deleted => false
      can :restore, Region, :is_deleted => true

      can :crud, ReportStructureCategory, :is_deleted => false

      can :crud, User, :is_deleted => false
      can :restore, User, :is_deleted => true

      can :manage, UserRole
    end

    if user.simple_user?
      can :read, City

      can :read, Dealer

      can :read, Region

      can :update, User, :id => user.id
      can :read, User
    end

  end
end
