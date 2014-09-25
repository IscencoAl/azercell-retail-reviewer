class ChartsController < ApplicationController
  # GET /charts/reports_score
  def reports_score
    data = Chart.reports_score(params[:filter], 20)

    render :json => {
      type: 'line',
      options: {
        title: t('controllers.charts.last_scores'),
        vAxis: { minValue: 0, maxValue: 5 },
        legend: { position: 'none' }
      },
      table: data
    }
  end

  # GET /charts/reports_count
  def reports_count
    data = Chart.reports_count(params[:filter], 30)

    render :json => {
      type: 'column',
      options: {
        title: t('controllers.charts.reports_count'),
        vAxis: { minValue: 0 },
        legend: { position: 'none' }
      },
      table: data
    }
  end

end