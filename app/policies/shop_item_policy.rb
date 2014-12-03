class ShopItemPolicy < ApplicationPolicy

  # Controller actions
  def index?
    true
  end

  def show?
    not record.is_deleted
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  # Helper actions
  def update_role?
    user.admin?
  end

  def update_dealer?
    user.admin?
  end

  # Scope
  class Scope < Scope
    def resolve
      if user.admin? or user.simple_user?
        scope.all
      else
        scope.where(:shop => ShopPolicy::Scope.new(user, Shop).resolve)
      end
    end
  end

end