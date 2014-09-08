class CreateReportStructureElementTypes < ActiveRecord::Migration
  def change
    create_table :report_structure_element_types do |t|
      t.string :name
    end
  end
end
