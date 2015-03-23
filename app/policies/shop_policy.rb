class ShopPolicy < ApplicationPolicy

  # Controller actions
  def index?
    true
  end

  def show?
    not record.is_deleted and (user.admin? or user.simple_user? or (user.reviewer? and record.user == user) or
      (user.dealer? and record.dealer == user.dealer))
  end

  def create?
    user.admin?
  end

  def update?
    not record.is_deleted and user.admin?
  end

  def destroy?
    not record.is_deleted and user.admin?
  end

  def restore?
    record.is_deleted and user.admin?
  end

  # Helper actions
  def filter_dealer?
    not user.dealer?
  end

  def filter_reviewer?
    not user.reviewer?
  end

  # Scope
  class Scope < Scope
    def resolve
      if user.reviewer?
        scope.where(:user => user)
      elsif user.dealer?
        scope.where(:dealer => user.dealer)
      else
        scope.all
      end
    end
  end

end