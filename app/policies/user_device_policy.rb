class UserDevicePolicy < ApplicationPolicy

  def index?
    Setting.max_user_devices_count != 0 and user.admin?
  end

  def destroy?
    user.admin? and record.created_at < Date.today
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