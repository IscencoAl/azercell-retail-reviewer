require 'rails_helper'

RSpec.describe 'Shops', :type => :request do

  describe 'GET /shops.json' do
    it 'has correct shops structure' do
      user = create(:user)

      city = create(:city, name: 'Testmouth')
      dealer = create(:dealer, name: 'Test Dealer')
      create_list(:shop, 5, dealer: dealer, city: city)

      get api_shops_path, { api_key: user.api_key, format: :json }

      hash = JSON.parse(response.body)

      expect(hash['dealers'][0]['name']).to eq('Test Dealer')
      expect(hash['dealers'][0]['cities'][0]['name']).to eq('Testmouth')
      expect(hash['dealers'][0]['cities'][0]['shops'].count).to eq(5)
    end
  end

end
