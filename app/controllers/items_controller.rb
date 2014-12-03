class ItemsController < ApplicationController
  before_action :load_item, only: [:show, :edit, :update, :destroy]

  helper_method :sorting_params

  # GET /items
  def index
    @items = policy_scope(Item)
    @items = @items.filter(filtering_params).sort(sorting_params)
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # GET /items/1/edit
  def edit
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:success] = t('controllers.items.created', name: @item.name)
      redirect_to session.delete(:return_to) || items_url
    else
      render :new
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      flash[:success] = t('controllers.items.updated', name: @item.name)
      redirect_to session.delete(:return_to) || items_url
    else
      render :edit
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    flash[:success] = t('controllers.items.destroyed', name: @item.name)
    redirect_to request.referer
  end

  private

  def load_item
    @item = Item.find(params[:id])
  end

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
