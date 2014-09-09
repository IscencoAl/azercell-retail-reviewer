require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe ReportStructureCategory, :type => :model do

  it_behaves_like "soft deletable", :report_structure_category, ReportStructureCategory

  describe 'factory' do
    it 'has a valid factory' do
      category = build(:report_structure_category)

      expect(category).to be_valid
    end

    context 'trait "deleted"' do
      it 'has a valid factory' do
        category = build(:report_structure_category)

        expect(category).to be_valid
      end

      it 'creates a deleted category' do
        category = build(:report_structure_category)

        expect(category.is_deleted).to be_falsey
      end
    end

    context 'trait "with_elements"' do
      it 'creates elements' do
        category = create(:report_structure_category_with_elements, :elements_count => 3)

        expect(category.elements.count).to eq(3)
      end
    end
  end

  describe '#delete_elements' do
    it 'destroy all category elements' do
      category = create(:report_structure_category_with_elements, :elements_count => 2)

      category.delete_elements

      expect(category.elements.count).to eq(0)
    end
  end

end
