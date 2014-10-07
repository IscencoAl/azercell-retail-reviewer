class ShopsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:restore, :restore_info, :map_info]

  helper_method :sorting_params

  # GET /shops
  def index
    @shops = @shops.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /shops/1
  def show
    @reports = @shop.reports.by_created_at('DESC').page(params[:page]).per(10)
  end

  # GET /shops/new
  def new
    session[:return_to] = request.referer
  end

  # GET /shops/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /shops
  def create
    if @shop.save
      flash[:success] = t('controllers.shops.created', name: @shop.full_address)
      redirect_to session.delete(:return_to)
    else
      render :new
    end
  end

  # PATCH/PUT /shops/1
  def update
    if @shop.update(shop_params)
      flash[:success] = t('controllers.shops.updated', name: @shop.full_address)
      redirect_to session.delete(:return_to)
    else
      render :edit
    end
  end

  # DELETE /shops/1
  def destroy
    @shop.soft_delete

    flash[:success] = t('controllers.shops.destroyed', name: @shop.full_address)
    redirect_to request.referer
  end

  # GET /shops/1/restore
  def restore
    session[:return_to] = request.referer
    @shop = Shop.deleted.find(params[:id])
  end

  # GET /shops/1/restore_info
  def restore_info
    @shop = Shop.deleted.find(params[:id])
    
    if @shop.update(shop_params)
      @shop.restore
      flash[:success] = t('controllers.shops.restored', name: @shop.full_address)
      redirect_to session.delete(:return_to)
    else
      render :restore
    end
  end

  # GET /shops/1/info
  def info
    if request.xhr?
      render :partial => "info", :locals => { :shop => @shop }
    end
  end

  # GET /shops/map_info
  def map_info
    @map_shops = Shop.select("id, latitude, longitude").all.map{ |shop| {:info => info_shop_path(shop), :latitude => shop.latitude, :longitude => shop.longitude}}
    render :json => @map_shops
  end

  private
    # Only allow a trusted parameter "white list" through.
    def shop_params
      params.require(:shop).permit(:shop_type_id, :city_id, :address, :latitude, :longitude,
        :dealer_id, :square_footage, :user_id, :is_deleted)
    end

    def filtering_params
      params.fetch(:filter, {}).permit(:type, :city, :address, :dealer, :user, :is_deleted)
    end

     def sorting_params
      params.fetch(:sort, {:col => "type", :dir => "asc"}).permit(:col, :dir)
    end
end
