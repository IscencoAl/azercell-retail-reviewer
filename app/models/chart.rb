class Chart < ActiveRecord::Base
  def self.reports_score(filtering_params = {}, limit = 10)
    reports = Report.filter(filtering_params).by_created_at('desc').limit(limit)

    return [] if reports.blank?

    reports = reports.map{ |r| [r.created_at.strftime("%d %b"), r.score.to_f] }.reverse
    return reports.unshift(['Date', 'Score'])
  end
end
