class ShopsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:restore]

  helper_method :sorting_params

  # GET /shops
  def index
    @shops = Shop.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /shops/1
  def show
    @reports = @shop.reports.order('created_at DESC').page(params[:page])
  end

  # GET /shops/new
  def new
  end

  # GET /shops/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /shops
  def create
    if @shop.save
      flash[:success] = t('controllers.shops.created', name: @shop.full_address)
      redirect_to shops_url
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
    redirect_to shops_url
  end

   # GET /shops/1/restore
  def restore
    @shop = Shop.deleted.find(params[:id])
    @shop.restore

    flash[:success] = t('controllers.shops.restored', name: @shop.full_address)
    redirect_to shops_url
  end

  # GET /shops/1/info
  def info
    if request.xhr?
      render :partial => "info"
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def shop_params
      params.require(:shop).permit(:type_id, :city_id, :address, :latitude, :longitude,
        :dealer_id, :square_footage, :user_id, :is_deleted)
    end

    def filtering_params
      params.fetch(:filter, {}).permit(:type, :city, :address, :dealer, :user, :is_deleted)
    end

     def sorting_params
      params.fetch(:sort, {:col => "type", :dir => "asc"}).permit(:col, :dir)
    end
end
