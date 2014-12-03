class ShopItemsController < ApplicationController
  before_action :load_shop_item, only: [:show, :edit, :update, :destroy]

  helper_method :sorting_params

  # GET /shop_items
  def index
    if redirected_from_shop?
      shop = load_shop
      shop_items = policy_scope(shop.shop_items)

      render :partial => 'shops/items/list', :locals => {:shop_items => shop_items, :shop => shop}
    else
      @shop_items = policy_scope(ShopItem)
      @shop_items = @shop_items.filter(filtering_params).sort(sorting_params).page(params[:page])
    end
  end

  # GET /shop_items/1
  def show
  end

  # GET /shop_items/new
  def new
    if redirected_from_shop?
      shop = load_shop
      shop_item = shop.shop_items.build

      render :partial => 'shops/items/new', :locals => {:shop_item => shop_item}
    else
      @shop_item = ShopItem.new
      session[:return_to] = request.referer unless request.referer == request.url
    end
  end

  # GET /shop_items/1/edit
  def edit
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # POST /shop_items
  def create
    if redirected_from_shop?
      shop = load_shop
      shop_item = shop.shop_items.build(shop_item_params)

      if shop_item.save
        redirect_to shop_shop_items_path(shop)
      else
        render :partial => 'shops/items/new', :locals => {:shop_item => shop_item}
      end
    else
      @shop_item = ShopItem.new(shop_item_params)

      if @shop_item.save
        flash[:success] = t('controllers.shop_items.created', name: @shop_item.item.name)
        redirect_to session.delete(:return_to) || shop_items_url
      else
        render :new
      end
    end
  end

  # PATCH/PUT /shop_items/1
  def update
    if @shop_item.update(shop_item_params)
      flash[:success] = t('controllers.shop_items.updated', name: @shop_item.item.name)
      redirect_to session.delete(:return_to) || shop_items_url
    else
      render :edit
    end
  end

  # DELETE /shop_items/1
  def destroy
    @shop_item.destroy
    if redirected_from_shop?
      shop = load_shop
      redirect_to shop_shop_items_path(shop), :status => 303
    else
      flash[:success] = t('controllers.shop_items.destroyed', name: @shop_item.item.name)
      redirect_to request.referer
    end
  end

  private

  def load_shop_item
    @shop_item = ShopItem.find(params[:id])
  end

  def shop_item_params
    params.require(:shop_item).permit(:item_id, :shop_id)
  end

  def filtering_params
    params.fetch(:filter, {}).permit(:shop, :item)
  end

  def sorting_params
    params.fetch(:sort, {:col => "item", :dir => "asc"}).permit(:col, :dir)
  end

  # Shop helper methods
  def load_shop
    Shop.find(params[:shop_id])
  end

  def redirected_from_shop?
    params.has_key?(:shop_id) and params[:shop_id].present?
  end
end
