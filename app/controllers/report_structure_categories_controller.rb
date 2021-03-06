class ReportStructureCategoriesController < ApplicationController
  before_action :load_category, only: [:show, :edit, :update, :destroy, 
    :increase_priority, :decrease_priority]

  # GET /report_structure_categories
  def index
    @categories = ReportStructureCategory.order(:priority)
    authorize @categories
  end

  # GET /report_structure_categories/1
  def show
    if request.xhr?
      respond_to do |format|
        format.html { render :partial => 'header', :locals => {:category => @category} }
      end
    end
  end

  # GET /report_structure_categories/new
  def new
    @category = ReportStructureCategory.new

    if request.xhr?
      respond_to do |format|
        format.html { render :partial => 'new' }
      end
    end
  end

  # GET /report_structure_categories/1/edit
  def edit
    if request.xhr?
      respond_to do |format|
        format.html { render :partial => 'form' }
      end
    end
  end

  # POST /report_structure_categories
  def create
    @category = ReportStructureCategory.new(category_params)

    if request.xhr?
      if @category.save
        redirect_to @category
      else
        render :partial => 'form'
      end
    end
  end

  # PATCH/PUT /report_structure_categories/1
  def update
    if request.xhr?
      if @category.update(category_params)
        redirect_to @category
      else
        render :partial => 'form'
      end
    end
  end

  # DELETE /report_structure_categories/1
  def destroy
    @category.soft_delete

    render :nothing => true
  end

  # GET /report_structure_categories/1/increase_priority
  def increase_priority
    render :json => { :success => @category.increase_priority }
  end

  # GET /report_structure_categories/1/decrease_priority
  def decrease_priority
    render :json => { :success => @category.decrease_priority }
  end

  private

  def load_category
    @category = ReportStructureCategory.find(params[:id])
  end

  def category_params
    params.require(:report_structure_category).permit(:name,:priority)
  end
end
