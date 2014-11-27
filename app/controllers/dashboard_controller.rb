class DashboardController < ApplicationController

  # GET /dashboard
  def index
    @reports = Report.by_created_at('desc').limit(10)
    @best_shops = Shop.by_score('desc').limit(3)
    @worst_shops = Shop.by_score('asc').by_address('desc').limit(3)
    @best_dealers = Dealer.by_score('desc').limit(3)
    @worst_dealers = Dealer.by_score('asc').limit(3)
    @not_reviewed_shops = Shop.not_reviewed(Date.today - 1.month)

    if cannot?(:dashboard, User) and can?(:dashboard, current_user)
      @reports = @reports.where(:user => current_user)
      @not_reviewed_shops = @not_reviewed_shops.where(:user => current_user)
    end
  end

end
