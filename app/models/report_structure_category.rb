class ReportStructureCategory < ActiveRecord::Base
  include Modules::SoftDelete
  
  validates :name,  :presence => true

  has_many :elements, :class_name => 'ReportStructureElement', :foreign_key => :report_structure_category_id, :dependent => :delete_all

  after_soft_delete :delete_elements

  def delete_elements
    elements.delete_all
  end

end