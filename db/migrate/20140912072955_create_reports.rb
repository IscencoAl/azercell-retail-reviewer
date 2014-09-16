class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.timestamp :created_at
      t.decimal :latitude, :precision => 9, :scale => 6
      t.decimal :longitude, :precision => 9, :scale => 6
      t.references :user, index: true
      t.references :shop, index: true
      t.decimal :score, :precision => 5, :scale => 2
    end
  end
end
