class DealersController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:restore]

  helper_method :sorting_params

  # GET /dealers
  def index
    @dealers = @dealers.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /dealers/1
  def show
  end

  # GET /dealers/new
  def new
    session[:return_to] = request.referer
  end

  # GET /dealers/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /dealers
  def create
    if @dealer.save
      flash[:success] = t('controllers.dealers.created', name: @dealer.name)
      redirect_to session.delete(:return_to)
    else
      render :new
    end
  end

  # PATCH/PUT /dealers/1
  def update
    if @dealer.update(dealer_params)
      flash[:success] = t('controllers.dealers.updated', name: @dealer.name)
      redirect_to session.delete(:return_to)
    else
      render :edit
    end
  end

  # DELETE /dealers/1
  def destroy
    @dealer.soft_delete
    flash[:success] = t('controllers.dealers.destroyed', name: @dealer.name)
    redirect_to request.referer
  end

  # GET /regions/1/restore
  def restore
    @dealer = Dealer.deleted.find(params[:id])
    @dealer.restore

    flash[:success] = t('controllers.dealers.restored', name: @dealer.name)
    redirect_to request.referer
  end

  private

    # Only allow a trusted parameter "white list" through.
    def dealer_params
      params.require(:dealer).permit(:name, :contact_name, :phone_number, :email)
    end

    def filtering_params
      params.fetch(:filter, {}).permit(:name, :contact_name, :is_deleted)
    end

    def sorting_params
      params.fetch(:sort, {:col => "name", :dir => "asc"}).permit(:col, :dir)
    end
end
