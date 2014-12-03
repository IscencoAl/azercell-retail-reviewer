class ReportsController < ApplicationController
  before_action :load_report, only: [:show]
  helper_method :sorting_params

  # GET /reports
  def index
    @reports = policy_scope(Report)
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

  def load_report
    @report = Report.find(params[:id])
  end

  def filtering_params
    params.fetch(:filter, {}).permit(:user, :shop, :score_from, :score_to, :date_from, :date_to)
  end

  def sorting_params
    params.fetch(:sort, {:col => 'created_at', :dir => 'desc'}).permit(:col, :dir)
  end
end
