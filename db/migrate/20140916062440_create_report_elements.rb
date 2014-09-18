class CreateReportElements < ActiveRecord::Migration
  def change
    create_table :report_elements do |t|
      t.string :name
      t.string :value
      t.references :report_structure_element_type, index: true
      t.references :report_structure_category, index: true
      t.references :report, index: true
    end
  end
end
