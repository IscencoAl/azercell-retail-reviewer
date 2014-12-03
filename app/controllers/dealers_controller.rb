class DealersController < ApplicationController
  before_action :load_dealer, only: [:show, :edit, :update, :destroy]

  helper_method :sorting_params

  # GET /dealers
  def index
    @dealers = policy_scope(Dealer)
    @dealers = @dealers.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /dealers/1
  def show
  end

  # GET /dealers/new
  def new
    @dealer = Dealer.new
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # GET /dealers/1/edit
  def edit
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # POST /dealers
  def create
    @dealer = Dealer.new(dealer_params)

    if @dealer.save
      flash[:success] = t('controllers.dealers.created', name: @dealer.name)
      redirect_to session.delete(:return_to) || dealers_url
    else
      render :new
    end
  end

  # PATCH/PUT /dealers/1
  def update
    if @dealer.update(dealer_params)
      flash[:success] = t('controllers.dealers.updated', name: @dealer.name)
      redirect_to session.delete(:return_to) || dealers_url
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

  def load_dealer
    @dealer = Dealer.find(params[:id])
  end

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
