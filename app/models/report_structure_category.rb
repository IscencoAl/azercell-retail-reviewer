class ReportStructureCategory < ActiveRecord::Base
  include Modules::SoftDelete
  
  validates :name,  :presence => true, :uniqueness => true
end
