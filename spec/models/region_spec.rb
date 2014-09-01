require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe Region, :type => :model do

  it_behaves_like "soft deletable", :region, Region

  describe "factory" do
    it "is valid" do
      region = create(:region)

      expect(region).to be_valid
    end

    context "deleted" do
      it "is valid" do
        region = create(:region, :deleted)

        expect(region).to be_valid
      end
    end
    
  end

end
