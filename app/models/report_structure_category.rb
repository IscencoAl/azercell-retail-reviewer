class ReportStructureCategory < ActiveRecord::Base
  include Modules::SoftDelete
  
  validates :name,  :presence => true

  has_many :elements, :class_name => 'ReportStructureElement', :foreign_key => :report_structure_category_id, :dependent => :delete_all

  after_save -> { self.touch }
  after_soft_delete :delete_elements, :recalculate_priority
  after_create :set_priority
  after_touch :change_shop_structure_version

  def increase_priority
    return false if self.priority == 1

    new_priority = self.priority - 1
    category_to_change = ReportStructureCategory.find_by_priority(new_priority)
    category_to_change.update_attribute(:priority, category_to_change.priority + 1)
    self.update_attribute(:priority, new_priority)
    
    true
  end

  def decrease_priority
    return false if self.priority == ReportStructureCategory.count

    new_priority = self.priority + 1
    category_to_change = ReportStructureCategory.find_by_priority(new_priority)
    category_to_change.update_attribute(:priority, category_to_change.priority -  1)
    self.update_attribute(:priority, new_priority)

    true
  end

  private

  def set_priority
    count = ReportStructureCategory.count
    self.update_attribute(:priority, count)
  end

  def self.recalculate_priority
    ReportStructureCategory.order(:priority).each_with_index do |cat, index|
      cat.update_attribute(:priority, index + 1)
    end
  end

  def delete_elements
    elements.delete_all
    self.touch
  end

  def change_shop_structure_version
    Setting.change_version('report_structure_version')
  end

end