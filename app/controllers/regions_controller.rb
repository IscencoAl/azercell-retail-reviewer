class RegionsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:restore]

  helper_method :sorting_params

  # GET /regions
  def index 
    @regions = Region.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /regions/1
  def show
  end

  # GET /regions/new
  def new
    session[:return_to] = request.referer
  end

  # GET /regions/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /regions
  def create
    if @region.save
      flash[:success] = t('controllers.regions.created', name: @region.name)
      redirect_to session.delete(:return_to)
    else
      render :new
    end
  end

  # PATCH/PUT /regions/1
  def update
    if @region.update(region_params)
      flash[:success] = t('controllers.regions.updated', name: @region.name)
      redirect_to session.delete(:return_to)
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
    # Only allow a trusted parameter "white list" through.
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
