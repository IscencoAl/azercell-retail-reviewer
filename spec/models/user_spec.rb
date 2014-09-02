require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe User, :type => :model do

  it_behaves_like "soft deletable", :user, User

  describe 'factory' do
    it 'has a valid factory' do
      user = build(:user)

      expect(user).to be_valid
    end

    context 'trait "deleted"' do
      it 'has a valid factory' do
        user = build(:user, :deleted)

        expect(user).to be_valid 
      end
    end

    context 'trait "invalid"' do
      it 'has an invalid factory' do
        user = build(:user, :invalid)

        expect(user).not_to be_valid
      end
    end
  end

  describe '#full_name' do
    it 'returns full old name' do
      user = create(:user, :name => 'John', :surname => 'Doe')

      user.name = "Josh"

      expect(user.full_name).to eql('John Doe')
    end
  end
  
end
