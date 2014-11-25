require 'rails_helper'

RSpec.describe 'Reports', :type => :request do

  describe 'GET /reports/structure.json' do
    it 'has correct report structure' do
      user = create(:user)
      create(:report_structure_category_with_elements, name: 'Test Category', elements_count: 5)
      get api_reports_structure_path, { api_key: user.api_key, format: :json }

      hash = JSON.parse(response.body)

      expect(hash['categories'][0]['name']).to eq('Test Category')
      expect(hash['categories'][0]['elements'].count).to eq(5)
    end
  end

  describe 'POST /reports.json' do
    context 'correct report' do
      it 'saves report' do
        user = create(:user)
        category = create(:report_structure_category, name: 'Test Category')
        shop = create(:shop)

        report = {
          geolocation: '39.503358 47.746996', shop_id: shop.id,
          categories: [
            { id: category.id,
              elements: [
                { name: 'Test element 1', value: 'no', type: 'input', weight: 10 },
                { name: 'Test element 2', value: 3, type: 'mark', weight: 3 },
                { name: 'Test element 3', value: 'yes', type: 'check', weight: 5 }
              ]
            }
          ]
        }

        post api_reports_path, { api_key: user.api_key, format: :json, report: report }

        expect(Report.all.count).to eq(1)
        expect(ReportElement.all.count).to eq(3)
      end
    end

    context 'report params missing' do
      it 'returns error' do
        user = create(:user)

        post api_reports_path, { api_key: user.api_key, format: :json }
        hash = JSON.parse(response.body)

        expect(hash['error']['message']).to include('Wrong report format:')
      end
    end
  end

end