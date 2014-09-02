require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe City, :type => :model do

  it_behaves_like "soft deletable", :city, City

  describe "factory" do
    it "is valid" do
      city = create(:city)

      expect(city).to be_valid
    end
  end

  describe "deleted" do
    it "is valid" do
      city = create(:city, :deleted)

      expect(city).to be_valid  
    end
  end

  describe "deleted region" do
    it "is equal" do
      city = create(:city)

      region = city.region
      region.soft_delete

      expect(city.region).to eq(region)
    end
  end
end
