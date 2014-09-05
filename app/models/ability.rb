class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, :to => :crud
    
    if user.admin?
      can :crud, User, :is_deleted => false
      can :restore, User, :is_deleted => true

      can :manage, UserRole

      can :crud, City

      can :crud, Region
    end

    if user.simple_user?
      can :update, User, :id => user.id
      can :read, User

      can :read, City
      
      can :read, Region
    end

  end
end
