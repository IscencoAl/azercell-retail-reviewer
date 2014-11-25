require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe Item, :type => :model do

  describe 'factory' do
    it 'has a valid factory' do
      item = build(:item)

      expect(item).to be_valid
    end
  end

  describe '.with_name' do
    context 'when part of name exists' do
      it 'returns corresponding item' do
        item = create(:item, :name => 'Nokia')

        ['ok', 'oKi', 'kia', 'Nok'].each do |name_part|
          expect(Item.with_name(name_part)).to eq([item])
        end
      end
    end

    context 'when part of name is absent' do
      it 'returns empty result' do
        item = create(:item, :name => 'Nokia')

        ['ak', 'oZi', 'ka', 'Nk'].each do |name_part|
          expect(Item.with_name(name_part)).to be_blank
        end
      end
    end
  end

  describe '.by_name' do
    context 'when asc' do
      it 'sorts ascending' do
        nokia = create(:item, :name => 'nokia')
        samsung = create(:item, :name => 'samsung')

        expect(Item.by_name('asc')).to eq([nokia, samsung])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        nokia = create(:item, :name => 'nokia')
        samsung = create(:item, :name => 'samsung')

        expect(Item.by_name('desc')).to eq([samsung, nokia])
      end
    end
  end

end