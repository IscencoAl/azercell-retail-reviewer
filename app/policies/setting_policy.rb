class SettingPolicy < ApplicationPolicy
  
  def index?
    user.super_admin?
  end

  def update?
    user.super_admin?
  end

  # Scope
  class Scope < Scope
    def resolve
      if user.super_admin?
        scope.all
      else
        scope.where('1 = 0')
      end
    end
  end
end