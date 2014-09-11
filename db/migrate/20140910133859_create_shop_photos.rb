class CreateShopPhotos < ActiveRecord::Migration
  def change
    create_table :shop_photos do |t|
      t.string :photo
      t.references :shop, index: true
    end
  end
end
