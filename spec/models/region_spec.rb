require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe Region, :type => :model do

  it_behaves_like "soft deletable", :region, Region

  describe "factory" do
    it "is valid" do
      region = create(:region)

      expect(region).to be_valid
    end

    context "trait 'deleted'" do
      it "is valid" do
        region = create(:region, :deleted)

        expect(region).to be_valid
      end
    end
    
    context 'trait "invalid"' do
      it 'has an invalid factory' do
        region = build(:region, :invalid)

        expect(region).not_to be_valid
      end
    end    
  end

  describe '.with_name' do
    context 'when part of name exists' do
      it 'returns corresponding region' do
        region = create(:region, :name => 'John')

        ['oh', 'oHn', 'joh', 'John'].each do |name_part|
          expect(Region.with_name(name_part)).to eq([region])
        end
      end
    end

    context 'when part of name is absent' do
      it 'returns empty result' do
        region = create(:region, :name => 'John')

        ['a', 'on', 'jh', 'Johns'].each do |name_part|
          expect(Region.with_name(name_part)).to eq([])
        end
      end
    end
  end

  describe '.with_is_deleted' do
    context 'when true' do
      it 'returns deleted user' do
        region = create(:region, :deleted)

        expect(Region.with_is_deleted(true)).to eq([region])
      end
    end

    context 'when is_deleted is nil' do
      it 'returns empty result' do
        region = create(:region, :deleted)

        expect(Region.with_is_deleted(nil)).to eq([])
      end
    end

    context 'when is_deleted is ""' do
      it 'returns empty result' do
        region = create(:region, :deleted)

        expect(Region.with_is_deleted("")).to eq([])
      end
    end

    context 'when is_deleted is false' do
      it 'returns empty result' do
        region = create(:region, :deleted)

        expect(Region.with_is_deleted(false)).to eq([])
      end
    end
  end

  describe '.by_name' do
    context 'when asc' do
      it 'sorts ascending' do
        center = create(:region, :name => 'Center')
        west = create(:region, :name => 'West')

        expect(Region.by_name('asc')).to eq([center, west])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        center = create(:region, :name => 'Center')
        west = create(:region, :name => 'West')

        expect(Region.by_name('desc')).to eq([west, center])
      end
    end
  end
end