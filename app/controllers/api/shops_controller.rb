class Api::ShopsController < Api::ApiController

  # GET /shops
  def index
    begin
      @shops_by_dealer = Hash[Dealer.all.map{ |d| [d, d.shops.group_by{|s| s.city}] }]
      @shops_by_dealer.each do |dealer, cities|
        cities.delete_if { |city, shops| shops.blank? }
      end
      @shops_by_dealer.delete_if { |dealer, cities| cities.blank? }
    rescue Exception => ex
      @msg = ex.message
      render 'api/common/error'
    end
  end

end