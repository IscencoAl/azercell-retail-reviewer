require 'rails_helper'

RSpec.describe ReportStructureElementType, :type => :model do

  it 'has predefined values' do
    elements = ReportStructureElementType.all.map{ |el| el.name }.to_set

    expect(elements).to be_eql Set.new(ReportStructureElementType::TYPES)
  end

  describe '.mark' do
    it 'returns type with name "mark"' do
      mark = ReportStructureElementType.mark

      expect(mark.name).to eq("mark")
    end
  end

  describe '.check' do
    it 'returns type with name "check"' do
      check = ReportStructureElementType.check

      expect(check.name).to eq("check")
    end
  end

  describe '.input' do
    it 'returns type with name "input"' do
      input = ReportStructureElementType.input

      expect(input.name).to eq("input")
    end
  end
  describe '.number' do
    it 'returns type with name "number"' do
      number = ReportStructureElementType.number

      expect(number.name).to eq("number")
    end
  end

end
