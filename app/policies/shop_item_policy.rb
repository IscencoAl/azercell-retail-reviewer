class ShopItemPolicy < ApplicationPolicy

  # Controller actions
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin? or user.simple_user? or (record.shop and ((user.reviewer? and record.shop.user == user) or
      (user.dealer? and record.shop.dealer == user.dealer)))
  end

  def destroy?
    user.admin? or user.simple_user? or (user.reviewer? and record.shop.user == user) or
      (user.dealer? and record.shop.dealer == user.dealer)
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