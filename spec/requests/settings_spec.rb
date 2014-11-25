require 'rails_helper'

RSpec.describe 'Reports', :type => :request do

  describe 'GET /reports/structure.json' do
    it 'has correct report structure' do
      user = create(:user)
      create(:report_structure_category_with_elements, name: 'Test Category', elements_count: 5)
      get api_settings_versions_path, { api_key: user.api_key, format: :json }

      hash = JSON.parse(response.body)

      expect(hash['app_version']).not_to be_blank
      expect(hash['shops_structure_version']).not_to be_blank
      expect(hash['report_structure_version']).not_to be_blank
    end
  end

end