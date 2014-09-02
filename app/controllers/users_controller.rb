class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

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
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :surname, :user_role_id, :subscription, :is_deleted,
        :email, :password, :password_confirmation)
    end
end
