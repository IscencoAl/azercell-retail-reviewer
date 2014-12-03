class RegionsController < ApplicationController
  before_action :load_region, only: [:show, :edit, :update, :destroy]

  helper_method :sorting_params

  # GET /regions
  def index
    @regions = policy_scope(Region)
    @regions = @regions.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /regions/1
  def show
  end

  # GET /regions/new
  def new
    @region = Region.new
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # GET /regions/1/edit
  def edit
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # POST /regions
  def create
    @region = Region.new(region_params)

    if @region.save
      flash[:success] = t('controllers.regions.created', name: @region.name)
      redirect_to session.delete(:return_to) || regions_url
    else
      render :new
    end
  end

  # PATCH/PUT /regions/1
  def update
    if @region.update(region_params)
      flash[:success] = t('controllers.regions.updated', name: @region.name)
      redirect_to session.delete(:return_to) || regions_url
    else
      render :edit
    end
  end

  # DELETE /regions/1
  def destroy
    @region.soft_delete
    flash[:success] = t('controllers.regions.destroyed', name: @region.name)
    redirect_to request.referer
  end
  
  # GET /regions/1/restore
  def restore
    @region = Region.deleted.find(params[:id])
    @region.restore

    flash[:success] = t('controllers.regions.restored', name: @region.name)
    redirect_to request.referer
  end

  private

  def load_region
    @region = Region.find(params[:id])
  end

  def region_params
    params.require(:region).permit(:name)
  end

  def filtering_params
    params.fetch(:filter, {}).permit(:name, :is_deleted)
  end

  def sorting_params
    params.fetch(:sort, {:col => "name", :dir => "asc"}).permit(:col, :dir)
  end
end
