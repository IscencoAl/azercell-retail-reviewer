class ChartsController < ApplicationController
  # GET /charts/reports_score
  def reports_score
    data = Chart.reports_score(params[:filter], 20)

    render :json => {
      type: 'one_line',
      options: {
        title: t('controllers.charts.last_scores'),
        vAxis: { minValue: 0, maxValue: 5 },
        legend: { position: 'none' }
      },
      table: data
    }
  end

end
