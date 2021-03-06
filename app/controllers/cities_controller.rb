class CitiesController < ApplicationController
  before_action :load_city, only: [:show, :edit, :update, :destroy]

  helper_method :sorting_params
  
  # GET /cities
  def index
    @cities = City.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /cities/1
  def show
  end

  # GET /cities/new
  def new
    @city = City.new
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # GET /cities/1/edit
  def edit
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # POST /cities
  def create
    @city = City.new(city_params)

    if @city.save
      flash[:success] = t('controllers.cities.created', name: @city.name)
      redirect_to session.delete(:return_to) || cities_url
    else
      render :new
    end
  end

  # PATCH/PUT /cities/1
  def update
    if @city.update(city_params)
      flash[:success] = t('controllers.cities.updated', name: @city.name)
      redirect_to session.delete(:return_to) || cities_url
    else
      render :edit
    end
  end

  # DELETE /cities/1
  def destroy
    @city.soft_delete
    flash[:success] = t('controllers.cities.destroyed', name: @city.name)
    redirect_to request.referer
  end

  # GET /cities/1/restore
  def restore
    @city = City.deleted.find(params[:id])
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # GET /cities/1/restore_info
  def restore_info
    @city = City.deleted.find(params[:id])

    if @city.update(city_params)
      @city.restore
      flash[:success] = t('controllers.cities.restored', name: @city.name)
      redirect_to session.delete(:return_to) || cities_url
    else
      render :restore
    end
  end

  private

  def load_city
    @city = City.find(params[:id])
  end

  def city_params
    params.require(:city).permit(:name, :region_id)
  end

  def filtering_params
    params.fetch(:filter, {}).permit(:name, :region, :is_deleted)
  end

  def sorting_params
    params.fetch(:sort, {:col => 'name', :dir => 'asc'}).permit(:col, :dir)
  end
end
