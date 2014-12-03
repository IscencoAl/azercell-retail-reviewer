class ShopsController < ApplicationController
  before_action :load_shop, only: [:show, :edit, :update, :destroy, :restore, :restore_info, :info,
                                   :employees, :new_employee, :create_employee, :items, :new_item, :create_item]
  before_action :load_shops, only: [:index, :map_info]
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
    @shop = Shop.new
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # GET /shops/1/edit
  def edit
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # POST /shops
  def create
    @shop = Shop.new(shop_params)

    if @shop.save
      flash[:success] = t('controllers.shops.created', name: @shop.name)
      redirect_to session.delete(:return_to) || shops_url
    else
      render :new
    end
  end

  # PATCH/PUT /shops/1
  def update
    if @shop.update(shop_params)
      flash[:success] = t('controllers.shops.updated', name: @shop.name)
      redirect_to session.delete(:return_to) || shops_url
    else
      render :edit
    end
  end

  # DELETE /shops/1
  def destroy
    @shop.soft_delete

    flash[:success] = t('controllers.shops.destroyed', name: @shop.name)
    redirect_to request.referer
  end

  # GET /shops/1/restore
  def restore
    session[:return_to] = request.referer  unless request.referer == request.url
    @shop = Shop.deleted.find(params[:id])
  end

  # GET /shops/1/restore_info
  def restore_info
    @shop = Shop.deleted.find(params[:id])
    
    if @shop.update(shop_params)
      @shop.restore
      flash[:success] = t('controllers.shops.restored', name: @shop.name)
      redirect_to session.delete(:return_to) || shops_url
    else
      render :restore
    end
  end

  # GET /shops/1/info
  def info
    if request.xhr?
      render :partial => 'info', :locals => { :shop => @shop }
    end
  end

  # GET /shops/map_info
  def map_info
    @shops = @shops.filter(filtering_params).all
      .map{ |shop| {:info => info_shop_path(shop), :latitude => shop.latitude, :longitude => shop.longitude} }

    render :json => @shops
  end

  # --================== Item methods ========================--

  # GET /shops/1/items
  def items
    items = @shop.shop_items
    if request.xhr?
      render :partial => "shops/items/list", :locals => {:items => items}
    end
  end

  # GET /shops/1/items/new
  def new_item
    item = ShopItem.new(:shop => @shop)
    if request.xhr?
      render :partial => "shops/items/new", :locals => {:item => item}
    end
  end

  # POST /shops/1/items/create
  def create_item
    item = ShopItem.new(item_params)
    item.shop = @shop
    
    if item.save
      render :partial => "shops/items/list", :locals => {:items => @shop.shop_items}
    else
      render :partial => "shops/items/new", :locals => {:item => item}
    end
  end

  # DELETE /shops/items/1
  def destroy_item
    item = ShopItem.find(params[:item_id])
    @shop = item.shop
    
    item.destroy
    if request.xhr?
      render :partial => "shops/items/list", :locals => {:items => @shop.shop_items}
    end
  end

  # --================== Employee methods ========================--

  # GET /shops/1/employees
  def employees
    employees = @shop.employees
    if request.xhr?
      render :partial => "shops/employees/list", :locals => {:employees => employees}
    end
  end

  # GET /shops/1/employees/new
  def new_employee
    employee = Employee.new(:shop => @shop)
    if request.xhr?
      render :partial => "shops/employees/new", :locals => {:employee => employee}
    end
  end

  # POST /shops/1/employees/create
  def create_employee
    employee = Employee.new(employee_params)
    employee.shop = @shop
    
    if employee.save
      render :partial => "shops/employees/list", :locals => {:employees => @shop.employees}
    else
      render :partial => "shops/employees/new", :locals => {:employee => employee}
    end
  end

  # GET /shops/employees/1/edit
  def edit_employee
    employee = Employee.find(params[:employee_id])

    if request.xhr?
      render :partial => "shops/employees/edit", :locals => {:employee => employee}
    end
  end

  # PATCH/PUT /shops/employees/1
  def update_employee
    employee = Employee.find(params[:employee_id])
    @shop = employee.shop
   
    if employee.update(employee_params)
      render :partial => "shops/employees/list", :locals => {:employees => @shop.employees}
    else
      render :partial => "shops/employees/edit", :locals => {:employee => employee}
    end
  end

  # DELETE /shops/employees/1
  def destroy_employee
    employee = Employee.find(params[:employee_id])
    @shop = employee.shop
    
    employee.soft_delete
    if request.xhr?
      render :partial => "shops/employees/list", :locals => {:employees => @shop.employees}
    end
  end

  private
    def load_shop
      @shop = Shop.find(params[:id])
    end

    def load_shops
      @shops = policy_scope(Shop)
    end

    # Only allow a trusted parameter "white list" through.
    def shop_params
      params.require(:shop).permit(:shop_type_id, :city_id, :address, :latitude, :longitude,
        :dealer_id, :square_footage, :user_id, :is_deleted)
    end

    def item_params
      params.require(:shop_item).permit(:item_id, :shop_id)
    end

    def employee_params
      params.require(:employee).permit(:name, :phone, :email, :shop_id, :employee_workposition_id, :is_deleted)
    end

    def filtering_params
      params.fetch(:filter, {}).permit(:type, :city, :region, :address, :dealer, :user, :is_deleted)
    end

    def sorting_params
      params.fetch(:sort, {:col => "type", :dir => "asc"}).permit(:col, :dir)
    end
end
