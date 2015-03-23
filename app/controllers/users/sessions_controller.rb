class Users::SessionsController < Devise::SessionsController

  def create
    User.unscoped do
      super
    end
  end

end