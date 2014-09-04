class CitiesController < ApplicationController
  load_and_authorize_resource
  
  # GET /cities
  def index
  end


  # GET /cities/new
  def new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  def create
    @city = City.new(city_params)

    if @city.save
      flash[:success] = t('controllers.cities.created', name: @city.name)
      redirect_to cities_url
    else
      render :new
    end
  end

  # PATCH/PUT /cities/1
  def update
    if @city.update(city_params)
      flash[:success] = t('controllers.cities.updated', name: @city.name)
      redirect_to cities_url
    else
      render :edit
    end
  end

  # DELETE /cities/1
  def destroy
    @city.soft_delete
    flash[:success] = t('controllers.cities.destroyed', name: @city.name)
    redirect_to cities_url
  end

  private

    # Only allow a trusted parameter "white list" through.
    def city_params
      params.require(:city).permit(:name, :region_id, :is_deleted)
    end
end
