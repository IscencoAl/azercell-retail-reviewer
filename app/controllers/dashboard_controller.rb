class DashboardController < ApplicationController
  def index
    @reports = Report.by_created_at("desc").limit(10)
    @best_shops = Shop.by_score("desc").limit(3)
    @worst_shops = Shop.by_score("asc").limit(3)
    @best_dealers = Dealer.by_score("desc").limit(3)
    @worst_dealers = Dealer.by_score("asc").limit(3)
  end
end