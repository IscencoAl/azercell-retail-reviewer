class ReportStructureElementsController < ApplicationController
  before_action :set_element, only: [:show, :edit, :update, :destroy, :increase_priority, :decrease_priority]

  # GET /report_structure_elements
  def index
    @elements = ReportStructureElements.order(:priority)
  end

  # GET /report_structure_elements/1
  def show
    if request.xhr?
      respond_to do |format|
        format.html { render :partial => 'show', :locals => {:element => @element} }
      end
    end
  end

  # GET /report_structure_elements/new
  def new
    @element = ReportStructureElement.new(element_params)

    if request.xhr?
      respond_to do |format|
        format.html { render :partial => 'form' }
      end
    end
  end

  # GET /report_structure_elements/1/edit
  def edit
    if request.xhr?
      respond_to do |format|
        format.html { render :partial => 'form' }
      end
    end
  end

  # POST /report_structure_elements
  def create
    @element = ReportStructureElement.new(element_params)

    if request.xhr?
      if @element.save
        redirect_to @element
      else
        render :partial => 'form'
      end
    end
  end

  # PATCH/PUT /report_structure_elements/1
  def update
    if request.xhr?
      if @element.update(element_params)
        redirect_to @element
      else
        render :partial => 'form'
      end
    end
  end

  # DELETE /report_structure_elements/1
  def destroy
    @element.destroy

    render :nothing => true
  end

  # DELETE /report_structure_elements/1
  def destroy
    @element.destroy

    render :nothing => true
  end

  # GET /report_structure_elements/1/increase_priority
  def increase_priority
    render :json => {:success => @element.increase_priority}
  end

  # GET /report_structure_elements/1/decrease_priority
  def decrease_priority
    render :json => {:success => @element.decrease_priority}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_element
      @element = ReportStructureElement.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def element_params
      params.require(:report_structure_element).permit(:name, :report_structure_element_type_id,
        :report_structure_category_id, :weight, :shop_types)
    end
end
