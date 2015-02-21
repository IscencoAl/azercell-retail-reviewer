class AddPriorityToReportStructureCategories < ActiveRecord::Migration
  def up
    add_column :report_structure_categories, :priority, :integer
  end

  def down
  	remove_column :report_structure_categories, :priority
  end
end
