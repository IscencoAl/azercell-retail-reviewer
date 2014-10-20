class ItemsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:restore]

  helper_method :sorting_params

  # GET /items
  def index
    @items = @items.filter(filtering_params).sort(sorting_params)
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    session[:return_to] = request.referer
  end

  # GET /items/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /items
  def create
    if @item.save
      flash[:success] = t('controllers.items.created', name: @item.name)
      redirect_to session.delete(:return_to)
    else
      render :new
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      flash[:success] = t('controllers.items.updated', name: @item.name)
      redirect_to session.delete(:return_to)
    else
      render :edit
    end
  end

  # DELETE /items/1
  def destroy
    @item.soft_delete
    flash[:success] = t('controllers.items.destroyed', name: @item.name)
    redirect_to request.referer
  end

  # GET /items/1/restore
  def restore
    @item = Item.deleted.find(params[:id])
    @item.restore

    flash[:success] = t('controllers.items.restored', name: @item.name)
    redirect_to request.referer
  end

  private
    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name)
    end

    def filtering_params
      params.fetch(:filter, {}).permit(:name, :is_deleted)
    end

    def sorting_params
      params.fetch(:sort, {:col => "name", :dir => "asc"}).permit(:col, :dir)
    end
end
