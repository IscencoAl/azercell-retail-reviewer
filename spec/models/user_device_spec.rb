require 'rails_helper'

RSpec.describe UserDevice, :type => :model do

  describe '.total_count' do
    context 'when maximum device count achieved' do
      before do
        create(:user_device)
        @device = UserDevice.create(:user => create(:user), :device_id => Faker::Bitcoin.address)
      end

      it 'adds errors' do
        expect(@device.errors).to be_any
      end
    end

    context 'when maximum device count not achieved' do
      before do
        @device = UserDevice.create(:user => create(:user), :device_id => Faker::Bitcoin.address)
      end

      it 'adds no errors' do
        expect(@device.errors).to be_blank
      end
    end
  end

end
