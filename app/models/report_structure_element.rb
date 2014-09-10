class ReportStructureElement < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :type, :presence => true
  validates :category, :presence => true
  validates :weight, :presence => true

  belongs_to :type, :class_name => 'ReportStructureElementType', :foreign_key => :report_structure_element_type_id
  belongs_to :category, :class_name => 'ReportStructureCategory', :foreign_key => :report_structure_category_id
end
