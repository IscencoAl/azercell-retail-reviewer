class CreateApiSettings < ActiveRecord::Migration
  def change
    create_table :api_settings do |t|
      t.string :name
      t.string :value
    end
  end
end
