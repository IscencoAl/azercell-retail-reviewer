class ReportStructureElementType < ActiveRecord::Base
  validates :name,  :presence => true, :uniqueness => true

  def self.mark
    find_by_name('mark')
  end

  def self.check
    find_by_name('check')
  end

  def self.input
    find_by_name('input')
  end
end
