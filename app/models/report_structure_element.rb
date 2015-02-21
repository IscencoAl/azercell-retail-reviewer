class ReportStructureElement < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :type, :presence => true
  validates :category, :presence => true
  validates :weight, :presence => true

  belongs_to :type, :class_name => 'ReportStructureElementType', :foreign_key => :report_structure_element_type_id
  belongs_to :category, :class_name => 'ReportStructureCategory', :foreign_key => :report_structure_category_id, touch: true
  
  after_create :set_priority
  after_destroy :recalculate_priority

  def increase_priority
    return false if self.priority == 1

    new_priority = self.priority - 1
    category = self.category
    element_to_change = category.elements.find_by_priority(new_priority)
    element_to_change.update_attribute(:priority, element_to_change.priority + 1)
    self.update_attribute(:priority, new_priority)

    true
  end

  def decrease_priority
    category = self.category
    return false if self.priority == category.elements.count

    new_priority = self.priority + 1
    element_to_change = category.elements.find_by_priority(new_priority)
    element_to_change.update_attribute(:priority, element_to_change.priority - 1)
    self.update_attribute(:priority, new_priority)

    true
  end

  private

  def set_priority
    category = self.category
    count = category.elements.count
    self.update_attribute(:priority, count)
  end

  def recalculate_priority
    self.category.elements.each_with_index do |el, index|
      el.update_attribute(:priority, index + 1)
    end
  end

end