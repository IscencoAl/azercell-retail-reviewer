class Api::ShopsController < Api::ApiController

  # GET /shops
  def index
    begin
      if Setting.find_by_name('review_associated_shops').value == 'yes'
        @shops_by_dealer = Dealer.all.map do |d|
            [d, d.shops.where(:user => current_user).group_by { |s| s.city }]
          end
      else
        @shops_by_dealer = Dealer.all.map{ |d| [d, d.shops.group_by{|s| s.city}] }
      end

      @shops_by_dealer = Hash[@shops_by_dealer]
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