class DealerPolicy < ApplicationPolicy

  # Controller actions
  def index?
    not user.dealer?
  end

  def show?
    not record.is_deleted and (not user.dealer? or user.dealer == record)
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
      unless user.dealer?
        scope.all
      else
        scope.where(:id => user.dealer_id)
      end
    end
  end

end