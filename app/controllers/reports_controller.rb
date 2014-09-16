class ReportsController < ApplicationController
  load_and_authorize_resource

  helper_method :sorting_params

  # GET /reports
  def index
    @reports = Report.filter(filtering_params).sort(sorting_params).page(params[:page])
  end

  # GET /reports/1
  def show
  end

  private

    def filtering_params
      params.fetch(:filter, {}).permit(:user, :shop, :score_from, :score_to)
    end

    def sorting_params
      params.fetch(:sort, {:col => "created_at", :dir => "desc"}).permit(:col, :dir)
    end
end
