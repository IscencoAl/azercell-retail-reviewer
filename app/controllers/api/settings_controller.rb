class Api::SettingsController < Api::ApiController

  # GET /settings/versions
  def versions
    begin
      @settings = Setting.where(:name => %w(app_version shops_structure_version report_structure_version))
    rescue Exception => ex
      @msg = ex.message
      render 'api/common/error'
    end
  end

end