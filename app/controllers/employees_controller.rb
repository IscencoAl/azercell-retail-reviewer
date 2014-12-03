class EmployeesController < ApplicationController
  before_action :load_employee, only: [:show, :edit, :update, :destroy]

  helper_method :sorting_params

  # GET /employees
  def index
    @employees = policy_scope(Employee)
    @employees = @employees.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /employees/1
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # GET /employees/1/edit
  def edit
    session[:return_to] = request.referer unless request.referer == request.url
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      flash[:success] = t('controllers.employees.created', name: @employee.name)
      redirect_to session.delete(:return_to) || employees_url
    else
      render :new
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      flash[:success] = t('controllers.employees.updated', name: @employee.name)
      redirect_to session.delete(:return_to) || employees_url
    else
      render :edit
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.soft_delete
    flash[:success] = t('controllers.employees.destroyed', name: @employee.name)
    redirect_to request.referer
  end

  # GET /employees/1/restore
  def restore
    @employee = Employee.deleted.find(params[:id])
    @employee.restore

    flash[:success] = t('controllers.employees.restored', name: @employee.name)
    redirect_to request.referer
  end

  private

  def load_employee
    @employee = Employee.find(params[:id])
  end

  def filtering_params
    params.fetch(:filter, {}).permit(:name, :shop, :employee_workposition, :is_deleted)
  end

  # Only allow a trusted parameter "white list" through.
  def employee_params
    params.require(:employee).permit(:name, :phone, :email, :shop_id, :employee_workposition_id, :is_deleted)
  end

  def sorting_params
    params.fetch(:sort, {:col => 'name', :dir => 'asc'}).permit(:col, :dir)
  end
end
