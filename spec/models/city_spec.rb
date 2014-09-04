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
  
end
