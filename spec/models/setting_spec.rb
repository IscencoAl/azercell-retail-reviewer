require 'rails_helper'

RSpec.describe Setting, :type => :model do
  
  describe 'factory' do
    it 'has a valid factory' do
      setting = build(:setting)

      expect(setting).to be_valid
    end
  end

  describe '.change_version' do
    context 'with blank name' do
      it 'returns false' do
        expect(Setting.change_version('')).to eq(false)
      end
    end

    context 'with unexisting name' do
      it 'returns true' do
        expect(Setting.change_version('test')).to eq(true)
      end

      it 'creates a new setting' do
        Setting.change_version('test')

        expect(Setting.find_by_name('test')).not_to be_blank
      end
    end

    context 'with existing name' do
      it 'returns true' do
        create(:setting, :name => 'test')

        expect(Setting.change_version('test')).to eq(true)
      end

      it 'changes version' do
        setting = create(:setting, :name => 'test', :value => '3')

        Setting.change_version('test')
        setting.reload

        expect(setting.value).not_to eq('3')
      end
    end

    context 'with version' do
      it 'sets required version' do
        Setting.change_version('test', '4')

        expect(Setting.find_by_name('test').value).to eq('4')
      end
    end
  end

end
