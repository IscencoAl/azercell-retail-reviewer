class EmployeesController < ApplicationController
  before_action :load_employee, only: [:show, :edit, :update, :destroy]

  helper_method :sorting_params

  # GET /employees
  def index
    if redirected_from_shop?
      shop = load_shop
      employees = policy_scope(shop.employees)

      render :partial => 'shops/employees/list', :locals => {:shop => shop, :employees => employees}
    else
      @employees = policy_scope(Employee)
      @employees = @employees.filter(filtering_params).sort(sorting_params).page(params[:page])
    end
  end

  # GET /employees/1
  def show
  end

  # GET /employees/new
  def new
    if redirected_from_shop?
      shop = load_shop
      employee = shop.employees.build

      render :partial => 'shops/employees/new', :locals => {:employee => employee}
    else
      @employee = Employee.new
      session[:return_to] = request.referer unless request.referer == request.url
    end
  end

  # GET /employees/1/edit
  def edit
    if redirected_from_shop?
      render :partial => 'shops/employees/edit', :locals => {:employee => @employee}
    else
      session[:return_to] = request.referer unless request.referer == request.url
    end
  end

  # POST /employees
  def create
    if redirected_from_shop?
      shop = load_shop
      employee = shop.employees.build(employee_params)

      if employee.save
        redirect_to shop_employees_path(shop)
      else
        render :partial => 'shops/employees/new', :locals => {:employee => employee}
      end
    else
      @employee = Employee.new(employee_params)

      if @employee.save
        flash[:success] = t('controllers.employees.created', name: @employee.name)
        redirect_to session.delete(:return_to) || employees_url
      else
        render :new
      end
    end
  end

  # PATCH/PUT /employees/1
  def update
    if redirected_from_shop?
      if @employee.update(employee_params)
        redirect_to shop_employees_path(@employee.shop)
      else
        render :partial => 'shops/employees/edit', :locals => {:employee => @employee}
      end
    else
      if @employee.update(employee_params)
        flash[:success] = t('controllers.employees.updated', name: @employee.name)
        redirect_to session.delete(:return_to) || employees_url
      else
        render :edit
      end
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.soft_delete
    if redirected_from_shop?
      redirect_to shop_employees_path(@employee.shop), :status => 303
    else
      flash[:success] = t('controllers.employees.destroyed', name: @employee.name)
      redirect_to request.referer
    end
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

  def employee_params
    params.require(:employee).permit(:name, :phone, :email, :shop_id, :employee_workposition_id, :is_deleted)
  end

  def sorting_params
    params.fetch(:sort, {:col => 'name', :dir => 'asc'}).permit(:col, :dir)
  end

  # Shop helper methods
  def load_shop
    Shop.find(params[:shop_id])
  end

  def redirected_from_shop?
    params.has_key?(:shop_id) and params[:shop_id].present?
  end
end
