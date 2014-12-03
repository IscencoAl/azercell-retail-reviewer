class ShopTypesController < ApplicationController
  before_action :load_shop_type, only: [:show, :edit, :update, :destroy]
  
  # GET /shop_types
  def index
    @shop_types = policy_scope(ShopType)
    @shop_types = @shop_types.filter(filtering_params).order(:name)
  end

  # GET /shop_types/1
  def show
  end

  # GET /shop_types/new
  def new
    @shop_type = ShopType.new
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # GET /shop_types/1/edit
  def edit
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # POST /shop_types
  def create
    @shop_type = ShopType.new(shop_type_params)

    if @shop_type.save
      flash[:success] = t('controllers.shop_types.created', name: @shop_type.name)
      redirect_to session.delete(:return_to) || shop_types_url
    else
      render :new
    end
  end

  # PATCH/PUT /shop_types/1
  def update
    if @shop_type.update(shop_type_params)
      flash[:success] = t('controllers.shop_types.updated', name: @shop_type.name)
      redirect_to session.delete(:return_to) || shop_types_url
    else
      render :edit
    end
  end

  # DELETE /shop_types/1
  def destroy
    @shop_type.soft_delete
    flash[:success] = t('controllers.shop_types.destroyed', name: @shop_type.name)
    redirect_to request.referer
  end
  
  # GET /shop_types/1/restore
  def restore
    @shop_type = ShopType.deleted.find(params[:id])
    @shop_type.restore

    flash[:success] = t('controllers.shop_types.restored', name: @shop_type.name)
    redirect_to request.referer
  end

  private

  def load_shop_type
    @shop_type = ShopType.find(params[:id])
  end

  def shop_type_params
    params.require(:shop_type).permit(:name, :abbreviation)
  end

  def filtering_params
    params.fetch(:filter, {}).permit(:name, :is_deleted)
  end
end
