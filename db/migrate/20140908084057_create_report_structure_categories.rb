class CreateReportStructureCategories < ActiveRecord::Migration
  def change
    create_table :report_structure_categories do |t|
      t.string :name
      t.boolean :is_deleted
    end
  end
end
