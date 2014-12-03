class ReportPolicy < ApplicationPolicy

  # Controller actions
  def index?
    true
  end

  def show?
    user.admin? or user.simple_user? or (user.reviewer? and record.user == user) or
      (user.dealer? and record.shop.dealer == user.dealer)
  end

  # Helper actions
  def filter_reviewer?
    not user.reviewer?
  end

  # Scope
  class Scope < Scope
    def resolve
      if user.admin? or user.simple_user?
        scope.all
      elsif user.reviewer?
        scope.where(:user => user)
      elsif user.dealer?
        scope.where(:shop => ShopPolicy::Scope.new(user, Shop).resolve)
      end
    end
  end

end