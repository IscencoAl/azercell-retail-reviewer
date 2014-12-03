class UserPolicy < ApplicationPolicy

  # Controller actions
  def index?
    user.admin? or user.simple_user?
  end

  def show?
    not record.is_deleted and record.reviewer? and (user.admin? or user.simple_user? or record == user)
  end

  def create?
    user.admin?
  end

  def update?
    not record.is_deleted and (user.admin? or record == user)
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
      if user.admin? or user.simple_user?
        scope.all
      else
        scope.where(:id => user.id)
      end
    end
  end

end