require 'rails_helper'

RSpec.describe ShopItem, :type => :model do

  describe 'factory' do
    it 'has a valid factory' do
      shop_item = build(:shop_item)

      expect(shop_item).to be_valid
    end
  end

  describe '.with_item' do
    context 'when shop items exist' do
      it 'returns corresponding shop item' do
        item = create(:item)
        shop_item = create(:shop_item, :item => item)

        expect(ShopItem.with_item(item.id)).to eq([shop_item])
      end
    end

    context 'when shop item is absent' do
      it 'returns empty result' do
        shop_item = create(:shop_item)

        expect(ShopItem.with_item(0)).to be_blank
      end
    end
  end

  describe '.with_shop' do
    context 'when shop item for shop exists' do
      it 'returns corresponding shop item' do
        shop = create(:shop)
        shop_item = create(:shop_item, :shop => shop)

        expect(ShopItem.with_shop(shop.id)).to eq([shop_item])
      end
    end

    context 'when shop item for shop is absent' do
      it 'returns empty result' do
        shop_item = create(:shop_item)

        expect(ShopItem.with_shop(0)).to be_blank
      end
    end
  end

  describe '.by_item' do
    context 'when asc' do
      it 'sorts ascending' do
        nokia = create(:shop_item, :item => create(:item, :name => 'Nokia'))
        samsung = create(:shop_item, :item => create(:item, :name => 'Samsung'))

        expect(ShopItem.by_item('asc')).to eq([nokia, samsung])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        nokia = create(:shop_item, :item => create(:item, :name => 'Nokia'))
        samsung = create(:shop_item, :item => create(:item, :name => 'Samsung'))

        expect(ShopItem.by_item('desc')).to eq([samsung, nokia])
      end
    end
  end

  describe '.by_shop' do
    context 'when asc' do
      it 'sorts ascending' do
        boston = create(:shop_item,
          :shop => create(:shop, :city => create(:city, :name => 'Boston'), :address => 'TV 141')
          )
        new_york = create(:shop_item,
          :shop => create(:shop, :city => create(:city, :name => 'New York'), :address => 'AB 11')
          )

        expect(ShopItem.by_shop('asc')).to eq([boston, new_york])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        boston = create(:shop_item,
          :shop => create(:shop, :city => create(:city, :name => 'Boston'), :address => 'TV 141')
          )
        new_york = create(:shop_item,
          :shop => create(:shop, :city => create(:city, :name => 'New York'), :address => 'AB 11')
          )

        expect(ShopItem.by_shop('desc')).to eq([new_york, boston])
      end
    end
  end

end
