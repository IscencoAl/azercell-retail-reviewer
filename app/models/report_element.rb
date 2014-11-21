class ReportElement < ActiveRecord::Base
  validates :name, :presence => true
  validates :value, :presence => true
  validates :type, :presence => true
  validates :category, :presence => true

  belongs_to :type, :class_name => 'ReportStructureElementType', :foreign_key => :report_structure_element_type_id
  belongs_to :category, :class_name => 'ReportStructureCategory', :foreign_key => :report_structure_category_id
  belongs_to :report
end
