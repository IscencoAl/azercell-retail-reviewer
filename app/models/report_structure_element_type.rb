class ReportStructureElementType < ActiveRecord::Base
  validates :name,  :presence => true, :uniqueness => true

  TYPES = ['mark', 'check', 'input', 'number']

  class << self
    TYPES.each do |type|
      define_method type do
        find_by_name(type)
      end
    end
  end
end
