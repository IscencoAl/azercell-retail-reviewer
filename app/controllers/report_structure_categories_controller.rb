class ReportStructureCategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /report_structure_categories
  def index
    @categories = ReportStructureCategory.all
  end

  # GET /report_structure_categories/1
  def show
    if request.xhr?
      respond_to do |format|
        format.html { render :partial => 'header' }
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
        render :partial => 'header'
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = ReportStructureCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:report_structure_category).permit(:name)
    end
end
