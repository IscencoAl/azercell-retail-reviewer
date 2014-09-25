class AddScoreToShopsAndDealers < ActiveRecord::Migration
  def change
    add_column :shops, :score, :decimal, :precision => 5, :scale => 2
    add_column :dealers, :score, :decimal, :precision => 5, :scale => 2
  end
end
