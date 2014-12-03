class DashboardController < ApplicationController

  # GET /dashboard
  def index
    @reports = policy_scope(Report.by_created_at('desc')).limit(10)
    @best_shops = policy_scope(Shop.where('score is not null').by_score('desc')).limit(3)
    @worst_shops = policy_scope(Shop.where('score is not null').by_score('asc')).limit(3)
    @best_dealers = Dealer.by_score('desc').limit(3)
    @worst_dealers = Dealer.by_score('asc').limit(3)
    @not_reviewed_shops = policy_scope(Shop.not_reviewed(Date.today - 1.month))
  end

end
