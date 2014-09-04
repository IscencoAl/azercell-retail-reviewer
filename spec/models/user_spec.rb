require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe User, :type => :model do

  it_behaves_like "soft deletable", :user, User

  describe 'factory' do
    it 'has a valid factory' do
      user = build(:user)

      expect(user).to be_valid
    end

    context 'trait "admin"' do
      it 'has a valid factory' do
        user = build(:user, :admin)

        expect(user).to be_valid 
      end
    end

    context 'trait "simple_user"' do
      it 'has a valid factory' do
        user = build(:user, :simple_user)

        expect(user).to be_valid 
      end
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

  describe '#admin?' do
    context 'when user has administrator role' do
      it 'returns true' do
        user = build(:user, :admin)

        expect(user.admin?).to eq(true)
      end
    end

    context 'when user has no administrator role' do
      it 'returns false' do
        user = build(:user, :simple_user)

        expect(user.admin?).to eq(false)
      end
    end
  end

  describe '#simple_user?' do
    context 'when user is simple user' do
      it 'returns true' do
        user = build(:user, :simple_user)

        expect(user.simple_user?).to eq(true)
      end
    end

    context 'when user is not simple user' do
      it 'returns true' do
        user = build(:user, :admin)

        expect(user.simple_user?).to eq(false)
      end
    end
  end
  
end
