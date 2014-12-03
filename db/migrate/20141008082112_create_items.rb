class CreateItems < ActiveRecord::Migration
  def change
    create_table :shop_items do |t|
      t.string :name
      t.boolean :is_deleted
    end
  end
end
