class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.references :shop_type, index: true
      t.references :city, index: true
      t.string :address
      t.decimal :latitude, :precision => 9, :scale => 6
      t.decimal :longitude, :precision => 9, :scale => 6
      t.references :dealer, index: true
      t.decimal :square_footage, :precision => 8, :scale => 2
      t.references :user, index: true
      t.boolean :is_deleted

    end
  end
end
