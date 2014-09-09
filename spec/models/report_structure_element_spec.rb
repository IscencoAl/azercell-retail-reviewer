require 'rails_helper'

RSpec.describe ReportStructureElement, :type => :model do
  
  describe 'factory' do
    it 'has a valid factory' do
      element = build(:report_structure_element)

      expect(element).to be_valid
    end
  end

end
