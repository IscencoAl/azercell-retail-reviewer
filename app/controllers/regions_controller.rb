class RegionsController < ApplicationController
  load_and_authorize_resource

  # GET /regions
  def index 
    @regions = Region.filter(filtering_params)
  end


  # GET /regions/new
  def new
  end

  # GET /regions/1/edit
  def edit
  end

  # POST /regions
  def create
    if @region.save
      flash[:success] = t('controllers.regions.created', name: @region.name)
      redirect_to regions_url
    else
      render :new
    end
  end

  # PATCH/PUT /regions/1
  def update
    if @region.update(region_params)
      flash[:success] = t('controllers.regions.updated', name: @region.name)
      redirect_to regions_url
    else
      render :edit
    end
  end

  # DELETE /regions/1
  def destroy
    @region.soft_delete
    flash[:success] = t('controllers.regions.destroyed', name: @region.name)
    redirect_to regions_url
  end

  private
    # Only allow a trusted parameter "white list" through.
    def region_params
      params.require(:region).permit(:name)
    end

    def filtering_params
      params.fetch(:filter, {}).permit(:name, :is_deleted)
    end
end
