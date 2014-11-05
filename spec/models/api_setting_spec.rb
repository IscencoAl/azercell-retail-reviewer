require 'rails_helper'

RSpec.describe ApiSetting, :type => :model do
  
  describe 'factory' do
    it 'has a valid factory' do
      api_setting = build(:api_setting)

      expect(api_setting).to be_valid
    end
  end

  describe '.change_version' do
    context 'with blank name' do
      it 'returns false' do
        expect(ApiSetting.change_version('')).to eq(false)
      end
    end

    context 'with unexisting name' do
      it 'returns true' do
        expect(ApiSetting.change_version('test')).to eq(true)
      end

      it 'creates a new setting' do
        ApiSetting.change_version('test')

        expect(ApiSetting.find_by_name('test')).not_to be_blank
      end
    end

    context 'with existing name' do
      it 'returns true' do
        create(:api_setting, :name => 'test')

        expect(ApiSetting.change_version('test')).to eq(true)
      end

      it 'changes version' do
        api_setting = create(:api_setting, :name => 'test', :value => '3')

        ApiSetting.change_version('test')
        api_setting.reload

        expect(api_setting.value).not_to eq('3')
      end
    end

    context 'with version' do
      it 'sets required version' do
        ApiSetting.change_version('test', '4')

        expect(ApiSetting.find_by_name('test').value).to eq('4')
      end
    end
  end

end
