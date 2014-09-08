require 'rails_helper'

RSpec.describe ReportStructureElementType, :type => :model do

  it 'has predefined values' do
    elements = ReportStructureElementType.all.map{ |el| el.name }.to_set

    expect(elements).to be_eql Set.new(['mark', 'check', 'input'])
  end

end
