class ReportsController < ApplicationController
  load_and_authorize_resource

  helper_method :sorting_params

  # GET /reports
  def index
    @reports = @reports.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /reports/1
  def show
    respond_to do |format|
      format.html
      format.pdf { render :pdf => "#{t('activerecord.models.report')}",
        :template => 'reports/show', :layout => 'layouts/pdf.html.erb', :encoding => 'utf-8;' }
    end
  end

  private

    def filtering_params
      params.fetch(:filter, {}).permit(:user, :shop, :score_from, :score_to, :date_from, :date_to)
    end

    def sorting_params
      params.fetch(:sort, {:col => "created_at", :dir => "desc"}).permit(:col, :dir)
    end
end
