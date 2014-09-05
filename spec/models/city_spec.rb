require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe City, :type => :model do

  it_behaves_like "soft deletable", :city, City

  describe "factory" do
    it "is valid" do
      city = create(:city)

      expect(city).to be_valid
    end

    context 'trait "invalid"' do
      it 'has an invalid factory' do
        city = build(:city, :invalid)

        expect(city).not_to be_valid
      end
    end

    context "trait 'deleted'" do
      it "is valid" do
        city = create(:city, :deleted)

        expect(city).to be_valid  
      end
    end
  end

  describe ".region" do
    context "when associated region is deleted" do
      it "return region" do
        city = create(:city)

        region = city.region
        region.soft_delete

        expect(city.region).to eq(region)
      end
    end
  end

  describe '.with_name' do
    context 'when part of name exists' do
      it 'returns corresponding city' do
        city = create(:city, :name => 'John')

        ['oh', 'oHn', 'joh', 'John'].each do |name_part|
          expect(City.with_name(name_part)).to eq([city])
        end
      end
    end

    context 'when part of name is absent' do
      it 'returns empty result' do
        city = create(:city, :name => 'John')

        ['a', 'on', 'jh', 'Johns'].each do |name_part|
          expect(City.with_name(name_part)).to eq([])
        end
      end
    end
  end
  
  describe '.with_is_deleted' do
    context 'when true' do
      it 'returns deleted city' do
        city = create(:city, :deleted)

        expect(City.with_is_deleted(true)).to eq([city])
      end
    end

    context 'when is_deleted is nil' do
      it 'returns empty result' do
        city = create(:city, :deleted)

        expect(City.with_is_deleted(nil)).to eq([])
      end
    end

    context 'when is_deleted is ""' do
      it 'returns empty result' do
        city = create(:city, :deleted)

        expect(City.with_is_deleted("")).to eq([])
      end
    end

    context 'when is_deleted is false' do
      it 'returns empty result' do
        city = create(:city, :deleted)

        expect(City.with_is_deleted(false)).to eq([])
      end
    end
  end
end
