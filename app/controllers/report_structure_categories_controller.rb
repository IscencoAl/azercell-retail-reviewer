class ReportStructureCategoriesController < ApplicationController
  before_action :set_report_structure_category, only: [:show, :edit, :update, :destroy]

  # GET /report_structure_categories
  def index
    @report_structure_categories = ReportStructureCategory.all
  end

  # GET /report_structure_categories/1
  def show
  end

  # GET /report_structure_categories/new
  def new
    @report_structure_category = ReportStructureCategory.new
  end

  # GET /report_structure_categories/1/edit
  def edit
  end

  # POST /report_structure_categories
  def create
    @report_structure_category = ReportStructureCategory.new(report_structure_category_params)

    if @report_structure_category.save
      redirect_to @report_structure_category, notice: 'Report structure category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /report_structure_categories/1
  def update
    if @report_structure_category.update(report_structure_category_params)
      redirect_to @report_structure_category, notice: 'Report structure category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /report_structure_categories/1
  def destroy
    @report_structure_category.destroy
    redirect_to report_structure_categories_url, notice: 'Report structure category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_structure_category
      @report_structure_category = ReportStructureCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def report_structure_category_params
      params.require(:report_structure_category).permit(:name)
    end
end
