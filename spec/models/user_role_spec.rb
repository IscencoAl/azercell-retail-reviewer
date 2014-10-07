require 'rails_helper'

RSpec.describe UserRole, :type => :model do

  it 'has predefined values' do
    user_roles = UserRole.all.map{ |ur| ur.name }.to_set

    expect(user_roles).to be_eql Set.new(['admin', 'user', 'reviewer', 'dealer'])
  end

  describe '.admin' do
    it 'return user role with name "admin"' do
      admin = UserRole.admin

      expect(admin.name).to eql('admin')
    end
  end

  describe '.user' do
    it 'return user role with name "user"' do
      user = UserRole.user

      expect(user.name).to eql('user')
    end
  end

  describe '.reviewer' do
    it 'return user role with name "reviewer"' do
      reviewer = UserRole.reviewer

      expect(reviewer.name).to eql('reviewer')
    end
  end

  describe '.dealer' do
    it 'return user role with name "dealer"' do
      dealer = UserRole.dealer

      expect(dealer.name).to eql('dealer')
    end
  end

end
