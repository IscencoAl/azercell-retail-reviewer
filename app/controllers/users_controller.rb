class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users
  def index
  end

  # GET /users/new
  def new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    if @user.save
      flash[:success] = t('controllers.users.created', name: @user.full_name)
      redirect_to users_url
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if params[:user][:password].blank?
      [:password, :password_confirmation].each{ |p| params[:user].delete(p) }
    end

    if @user.update(user_params)
      flash[:success] = t('controllers.users.updated', name: @user.full_name)
      redirect_to users_url
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.soft_delete

    flash[:success] = t('controllers.users.destroyed', name: @user.full_name)
    redirect_to users_url
  end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :surname, :user_role_id, :subscription,
        :email, :password, :password_confirmation)
    end
end
