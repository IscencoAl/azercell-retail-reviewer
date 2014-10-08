class CreateShopItems < ActiveRecord::Migration
  def change
    create_table :shop_items do |t|
      t.references :item, index: true
      t.references :shop, index: true
    end
  end
end
