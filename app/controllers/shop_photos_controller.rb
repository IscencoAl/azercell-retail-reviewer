class ShopPhotosController < ApplicationController
  before_action :set_shop_photo, only: [:show, :destroy]

  # GET /shop_photo/1
  def show
    if request.xhr?
      render :partial => 'show', :locals => { :shop_photo => @shop_photo }
    end
  end

  # POST /shop_photo
  def create
    @shop_photo = ShopPhoto.new(shop_photo_params)

    if request.xhr?
      if @shop_photo.save
        redirect_to @shop_photo
      end
    end
  end

  # DELETE /shop_photo/1
  def destroy
    @shop_photo.destroy

    if request.xhr?
      respond_to do |format|
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_photo
      @shop_photo = ShopPhoto.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shop_photo_params
      params.require(:shop_photo).permit(:photo, :shop_id)
    end
end
