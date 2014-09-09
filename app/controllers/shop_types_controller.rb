class ShopTypesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:restore]

  
  # GET /shop_types
  def index
    @shop_types = ShopType.filter(filtering_params).order(:name)
  end

  # GET /shop_types/1
  def show
  end

  # GET /shop_types/new
  def new
  end

  # GET /shop_types/1/edit
  def edit
  end

  # POST /shop_types
  def create
    if @shop_type.save
      flash[:success] = t('controllers.shop_types.created', name: @shop_type.name)
      redirect_to shop_types_url
    else
      render :new
    end
  end

  # PATCH/PUT /shop_types/1
  def update
    if @shop_type.update(shop_type_params)
      flash[:success] = t('controllers.shop_types.updated', name: @shop_type.name)
      redirect_to shop_types_url
    else
      render :edit
    end
  end

  # DELETE /shop_types/1
  def destroy
    @shop_type.soft_delete
    flash[:success] = t('controllers.shop_types.destroyed', name: @shop_type.name)
    redirect_to shop_types_url
  end
  # GET /shop_types/1/restore
  def restore
    @shop_type = ShopType.deleted.find(params[:id])
    @shop_type.restore

    flash[:success] = t('controllers.shop_types.restored', name: @shop_type.name)
    redirect_to shop_types_url
  end

  private
    # Only allow a trusted parameter "white list" through.
    def shop_type_params
      params.require(:shop_type).permit(:name, :abbreviation)
    end

    def filtering_params
      params.fetch(:filter, {}).permit(:name, :is_deleted)
    end
end
