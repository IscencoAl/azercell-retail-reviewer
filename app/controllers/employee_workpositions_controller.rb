class EmployeeWorkpositionsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:restore]

  # GET /employee_workpositions
  def index
    @employee_workpositions =  @employee_workpositions.filter(filtering_params).order(:name)
  end

  # GET /employee_workpositions/1
  def show
  end

  # GET /employee_workpositions/new
  def new
    session[:return_to] = request.referer
  end

  # GET /employee_workpositions/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /employee_workpositions
  def create
    if @employee_workposition.save
      flash[:success] = t('controllers.employee_workpositions.created', name: @employee_workposition.name)
      redirect_to session.delete(:return_to)
    else
      render :new
    end
  end

  # PATCH/PUT /employee_workpositions/1
  def update
    if @employee_workposition.update(employee_workposition_params)
      flash[:success] = t('controllers.employee_workpositions.updated', name: @employee_workposition.name)
      redirect_to session.delete(:return_to)
    else
      render :edit
    end
  end

  # DELETE /employee_workpositions/1
  def destroy
    @employee_workposition.soft_delete
    flash[:success] = t('controllers.employee_workpositions.destroyed', name: @employee_workposition.name)
    redirect_to request.referer
  end

  # GET /employee_workpositions/1/restore
  def restore
    @employee_workposition = EmployeeWorkposition.deleted.find(params[:id])
    @employee_workposition.restore

    flash[:success] = t('controllers.employee_workpositions.restored', name: @employee_workposition.name)
    redirect_to request.referer
  end

  private
    # Only allow a trusted parameter "white list" through.
    def employee_workposition_params
      params.require(:employee_workposition).permit(:name)
    end

    def filtering_params
      params.fetch(:filter, {}).permit(:name, :is_deleted)
    end
end
