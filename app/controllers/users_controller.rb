class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  helper_method :sorting_params

  # GET /users
  def index
    @users = policy_scope(User)
    @users = @users.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /users/1
  def show
    @reports = @user.reports.order('created_at DESC').page(params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # GET /users/1/edit
  def edit
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = t('controllers.users.created', name: @user.full_name)
      redirect_to session.delete(:return_to) || users_path
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
      redirect_to session.delete(:return_to) || users_path
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.soft_delete

    flash[:success] = t('controllers.users.destroyed', name: @user.full_name)
    redirect_to request.referer
  end

  # GET /users/1/restore
  def restore
    @user = User.deleted.find(params[:id])
    @user.restore

    flash[:success] = t('controllers.users.restored', name: @user.full_name)
    redirect_to request.referer
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :surname, :user_role_id, :subscription,
      :email, :password, :password_confirmation, :dealer_id)
  end

  def filtering_params
    params.fetch(:filter, {}).permit(:name, :surname, :role, :email, :is_deleted)
  end

  def sorting_params
    params.fetch(:sort, {:col => "name", :dir => "asc"}).permit(:col, :dir)
  end
end
