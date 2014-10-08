class ShopItemsController < ApplicationController
  load_and_authorize_resource

  helper_method :sorting_params

  # GET /shop_items
  def index
    @shop_items = @shop_items.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /shop_items/1
  def show
  end

  # GET /shop_items/new
  def new
    session[:return_to] = request.referer
  end

  # GET /shop_items/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /shop_items
  def create
    if @shop_item.save
      flash[:success] = t('controllers.shop_items.created', name: @shop_item.item.name)
      redirect_to session.delete(:return_to)
    else
      render :new
    end
  end

  # PATCH/PUT /shop_items/1
  def update
    if @shop_item.update(shop_item_params)
      flash[:success] = t('controllers.shop_items.updated', name: @shop_item.item.name)
      redirect_to session.delete(:return_to)
    else
      render :edit
    end
  end

  # DELETE /shop_items/1
  def destroy
    @shop_item.destroy
    flash[:success] = t('controllers.shop_items.destroyed', name: @shop_item.item.name)
    redirect_to request.referer
  end

  private
    # Only allow a trusted parameter "white list" through.
    def shop_item_params
      params.require(:shop_item).permit(:item_id, :shop_id)
    end

    def filtering_params
      params.fetch(:filter, {}).permit(:shop, :item)
    end

    def sorting_params
      params.fetch(:sort, {:col => "item", :dir => "asc"}).permit(:col, :dir)
    end
end
