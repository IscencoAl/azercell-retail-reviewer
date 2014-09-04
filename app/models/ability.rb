class Ability
  include CanCan::Ability

  def initialize(user)
    
    if user.admin?
      can :manage, User
      can :manage, UserRole
      can :manage, City
      can :manage, Region
    end

    if user.simple_user?
      can :update, User, :id => user.id
      can :read, User
      can :read, City
      can :read, Region
    end

  end
end
