class Ability
  include CanCan::Ability

  def initialize(user)
    
    if user.admin?
      can :manage, User
      can :manage, UserRole
    end

    if user.simple_user?
      can :update, User, :id => user.id
      can :read, User
    end

  end
end
