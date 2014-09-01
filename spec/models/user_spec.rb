require 'rails_helper'

RSpec.describe User, :type => :model do

  describe 'factory' do
    it 'has a valid factory' do
      user = create(:user)

      expect(user).to be_valid
    end

    context 'trait "deleted"' do
      it 'has a valid factory' do
        user = create(:user, :deleted)

        expect(user).to be_valid 
      end
    end
  end

  describe '#full_name' do
    it 'returns full name' do
      user = create(:user, :name => 'John', :surname => 'Doe')

      expect(user.full_name).to eql('John Doe')
    end
  end
  
end
