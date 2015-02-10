class AddNumberToReportStructureElementTypes < ActiveRecord::Migration
  def up
    ReportStructureElementType.create({:name => "number"})
  end

  def down
    number = ReportStructureElementType.find_by_name("number")
    number.destroy
  end  
end
