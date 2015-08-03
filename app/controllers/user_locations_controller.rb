class UserLocationsController < ApplicationController
  # GET /user_locations
  def index
    @locations = filtering_params.any? ? UserLocation.filter(filtering_params).order(:id) : []

    render :json => @locations
  end

  # GET /user_locations/map
  def map
  end

  private

  def filtering_params
    params.fetch(:filter, {}).permit(:user, :created_at_from, :created_at_to)
  end
end
