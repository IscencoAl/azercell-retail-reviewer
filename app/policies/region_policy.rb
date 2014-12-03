class RegionPolicy < ApplicationPolicy

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
    not record.is_deleted and user.admin?
  end

  def destroy?
    not record.is_deleted and user.admin? and record.cities.blank?
  end

  def restore?
    record.is_deleted and user.admin?
  end

  # Scope
  class Scope < Scope
    def resolve
      scope.all
    end
  end

end