require 'rails_helper'

RSpec.describe ReportElement, :type => :model do

  describe 'factory' do
    it 'has a valid factory' do
      elem = build(:report_element)

      expect(elem).to be_valid
    end
  end

end
