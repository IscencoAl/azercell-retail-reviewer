class EmployeePolicy < ApplicationPolicy

  # Controller actions
  def index?
    true
  end

  def show?
    not record.is_deleted
  end

  def create?
    user.admin? or user.simple_user? or (record.shop and ((user.reviewer? and record.shop.user == user) or
      (user.dealer? and record.shop.dealer == user.dealer)))
  end

  def update?
    not record.is_deleted and (user.admin? or user.simple_user? or (user.reviewer? and record.shop.user == user) or
      (user.dealer? and record.shop.dealer == user.dealer))
  end

  def destroy?
    not record.is_deleted and (user.admin? or user.simple_user? or (user.reviewer? and record.shop.user == user) or
      (user.dealer? and record.shop.dealer == user.dealer))
  end

  def restore?
    record.is_deleted and (user.admin? or user.simple_user? or (user.reviewer? and record.shop.user == user) or
      (user.dealer? and record.shop.dealer == user.dealer))
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