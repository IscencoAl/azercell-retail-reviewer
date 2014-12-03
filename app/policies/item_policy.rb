class ItemPolicy < ApplicationPolicy

  # Controller actions
  def index?
    user.admin?
  end

  def show?
    not record.is_deleted
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
  def update_role?
    user.admin?
  end

  def update_dealer?
    user.admin?
  end

  # Scope
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where('1 = 0')
      end
    end
  end

end