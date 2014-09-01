class RegionsController < ApplicationController
  before_action :set_region, only: [:show, :edit, :update, :destroy]

  # GET /regions
  def index
    @regions = Region.all
  end

  # GET /regions/1
  def show
  end

  # GET /regions/new
  def new
    @region = Region.new
  end

  # GET /regions/1/edit
  def edit
  end

  # POST /regions
  def create
    @region = Region.new(region_params)

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
    # Use callbacks to share common setup or constraints between actions.
    def set_region
      @region = Region.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def region_params
      params.require(:region).permit(:name, :is_deleted)
    end
end
