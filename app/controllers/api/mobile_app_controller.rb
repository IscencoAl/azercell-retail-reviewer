class Api::MobileAppController < Api::ApiController

  # GET /mobile_app
  def index
    begin
      send_file(Rails.root.join('public', 'RetailReviewer.apk'))
    rescue Exception => ex
      @msg = ex.message
      render 'api/common/error'
    end
  end

end
