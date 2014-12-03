class DashboardPolicy < ApplicationPolicy

  # Controller actions
  def index?
    true
  end

end