class CreateReportStructureElements < ActiveRecord::Migration
  def change
    create_table :report_structure_elements do |t|
      t.string :name
      t.references :report_structure_element_type
      t.references :report_structure_category
      t.integer :weight
      t.string :shop_types
    end
  end
end
