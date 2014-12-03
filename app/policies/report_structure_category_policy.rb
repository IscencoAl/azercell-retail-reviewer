class ReportStructureCategoryPolicy < ApplicationPolicy

  # Controller actions
  def index?
    user.admin?
  end

end