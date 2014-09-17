class CreateReportPhotos < ActiveRecord::Migration
  def change
    create_table :report_photos do |t|
      t.string :photo
      t.references :report, index: true
    end
  end
end
