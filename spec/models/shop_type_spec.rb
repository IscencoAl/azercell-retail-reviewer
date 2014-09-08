require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe ShopType, :type => :model do
  it_behaves_like "soft deletable", :shop_type, ShopType

  describe "factory" do
    it "is valid" do
      shop_type = create(:shop_type)

      expect(shop_type).to be_valid
    end

    context "trait 'deleted'" do
      it "is valid" do
        shop_type = create(:shop_type, :deleted)

        expect(shop_type).to be_valid
      end
    end
    
    context 'trait "invalid"' do
      it 'has an invalid factory' do
        shop_type = build(:shop_type, :invalid)

        expect(shop_type).not_to be_valid
      end
    end    
  end

  describe '.with_name' do
    context 'when part of name exists' do
      it 'returns corresponding shop_type' do
        shop_type = create(:shop_type, :name => 'John')

        ['oh', 'oHn', 'joh', 'John'].each do |name_part|
          expect(ShopType.with_name(name_part)).to eq([shop_type])
        end
      end
    end

    context 'when part of name is absent' do
      it 'returns empty result' do
        shop_type = create(:shop_type, :name => 'John')

        ['a', 'on', 'jh', 'Johns'].each do |name_part|
          expect(ShopType.with_name(name_part)).to eq([])
        end
      end
    end
  end

  describe '.with_is_deleted' do
    context 'when true' do
      it 'returns deleted shop_type' do
        shop_type = create(:shop_type, :deleted)

        expect(ShopType.with_is_deleted(true)).to eq([shop_type])
      end
    end

    context 'when is_deleted is nil' do
      it 'returns empty result' do
        shop_type = create(:shop_type, :deleted)

        expect(ShopType.with_is_deleted(nil)).to eq([])
      end
    end

    context 'when is_deleted is ""' do
      it 'returns empty result' do
        shop_type = create(:shop_type, :deleted)

        expect(ShopType.with_is_deleted("")).to eq([])
      end
    end

    context 'when is_deleted is false' do
      it 'returns empty result' do
        shop_type = create(:shop_type, :deleted)

        expect(ShopType.with_is_deleted(false)).to eq([])
      end
    end
  end
  
end
