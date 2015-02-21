class AddPriorityToReportStructureElements < ActiveRecord::Migration
  def up
    add_column :report_structure_elements, :priority, :integer
  end
  def down
  	remove_column :report_structure_elements, :priority
  end
end
