class CreateShopTypes < ActiveRecord::Migration
  def change
    create_table :shop_types do |t|
      t.string :name
      t.string :abbreviation
      t.boolean :is_deleted

    end
  end
end
