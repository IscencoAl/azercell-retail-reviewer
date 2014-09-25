class Chart < ActiveRecord::Base
  def self.reports_score(filtering_params = {}, limit = 10)
    reports = Report.filter(filtering_params).by_created_at('desc').limit(limit)

    return [] if reports.blank?

    reports = reports.map{ |r| [r.created_at.strftime("%d %b"), r.score.to_f] }.reverse
    return reports.unshift(['Date', 'Score'])
  end

  def self.reports_count(filtering_params = {}, days = 7)
    date = Date.today - days.days
    result = Hash.new

    (date..Date.today).each do |day|
      result[day.strftime("%d %b")] = 0
    end

    reports = Report.select('count(id) as count, date(created_at) as created_at').filter(filtering_params)
      .with_date_from(date).by_created_at('desc').group('date(created_at)')

    return [] if reports.blank?

    reports.each do |report|
      result[report.created_at.strftime("%d %b")] = report.count
    end

    return result.to_a.unshift(['Date', 'Count'])
  end
end
