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

    context 'trait "reviewer"' do
      it 'has a valid factory' do
        user = build(:user, :reviewer)

        expect(user).to be_valid 
      end
    end

     context 'trait "user_dealer"' do
      it 'has a valid factory' do
        user = build(:user, :user_dealer)

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

  describe '.with_name' do
    context 'when part of name exists' do
      it 'returns corresponding user' do
        user = create(:user, :name => 'John')

        ['oh', 'oHn', 'joh', 'John'].each do |name_part|
          expect(User.with_name(name_part)).to eq([user])
        end
      end
    end

    context 'when part of name is absent' do
      it 'returns empty result' do
        user = create(:user, :name => 'John')

        ['a', 'on', 'jh', 'Johns'].each do |name_part|
          expect(User.with_name(name_part)).to eq([])
        end
      end
    end
  end

  describe '.with_surname' do
    context 'when part of surname exists' do
      it 'returns corresponding user' do
        user = create(:user, :surname => 'Johnson')

        ['john', 'oHn', 'son', 'Johnson'].each do |surname_part|
          expect(User.with_surname(surname_part)).to eq([user])
        end
      end
    end

    context 'when part of surname is absent' do
      it 'returns empty result' do
        user = create(:user, :surname => 'Johnson')

        ['a', 'nsn', 'Johnsons'].each do |surname_part|
          expect(User.with_surname(surname_part)).to eq([])
        end
      end
    end
  end

  describe '.with_email' do
    context 'when part of email exists' do
      it 'returns corresponding user' do
        user = create(:user, :email => 'John.doe@fake.com')

        ['john', '.Doe', '@fake', 'John.doe@fake.com'].each do |email_part|
          expect(User.with_email(email_part)).to eq([user])
        end
      end
    end

    context 'when part of email is absent' do
      it 'returns empty result' do
        user = create(:user, :email => 'John.doe@fake.com')

        ['z', 'n.oe@', '1John.doe@fake.com'].each do |email_part|
          expect(User.with_email(email_part)).to eq([])
        end
      end
    end
  end

  describe '.with_role' do
    context 'when role exists' do
      it 'returns corresponding user' do
        user = create(:user, :admin)

        expect(User.with_role(UserRole.admin)).to eq([user])
      end
    end

    context 'when role is absent' do
      it 'returns empty result' do
        user = create(:user)

        expect(User.with_role(0)).to eq([])
      end
    end
  end

  describe '.with_is_deleted' do
    context 'when true' do
      it 'returns deleted user' do
        user = create(:user, :deleted)

        expect(User.with_is_deleted(true)).to eq([user])
      end
    end

    context 'when is_deleted is nil' do
      it 'returns empty result' do
        user = create(:user, :deleted)

        expect(User.with_is_deleted(nil)).to eq([])
      end
    end

    context 'when is_deleted is ""' do
      it 'returns empty result' do
        user = create(:user, :deleted)

        expect(User.with_is_deleted("")).to eq([])
      end
    end

    context 'when is_deleted is false' do
      it 'returns empty result' do
        user = create(:user, :deleted)

        expect(User.with_is_deleted(false)).to eq([])
      end
    end
  end

  describe '#full_name' do
    it 'returns full name' do
      user = build(:user, :name => 'John', :surname => 'Doe')

      expect(user.full_name).to eql('John Doe')
    end
  end

  describe '#full_name_was' do
    it 'returns old full name' do
      user = create(:user, :name => 'John', :surname => 'Doe')

      user.name = 'Josh'

      expect(user.full_name_was).to eql('John Doe')
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

  describe '#reviewer?' do
    context 'when user is reviewer' do
      it 'returns true' do
        user = build(:user, :reviewer)

        expect(user.reviewer?).to eq(true)
      end
    end

    context 'when user is not reviewer' do
      it 'returns true' do
        user = build(:user, :admin)

        expect(user.reviewer?).to eq(false)
      end
    end
  end

  describe '#dealer?' do
    context 'when user has dealer role' do
      it 'returns true' do
        user = build(:user, :user_dealer)

        expect(user.dealer?).to eq(true)
      end
    end

    context 'when user has no dealer role' do
      it 'returns false' do
        user = build(:user, :simple_user)

        expect(user.dealer?).to eq(false)
      end
    end
  end

  describe '.by_name' do
    context 'when asc' do
      it 'sorts ascending' do
        john = create(:user, :name => 'John')
        michael = create(:user, :name => 'Michael')

        expect(User.by_name('asc')).to eq([john, michael])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        john = create(:user, :name => 'John')
        michael = create(:user, :name => 'Michael')

        expect(User.by_name('desc')).to eq([michael, john])
      end
    end
  end

  describe '.by_surname' do
    context 'when asc' do
      it 'sorts ascending' do
        john = create(:user, :surname => 'John')
        michael = create(:user, :surname => 'Michael')

        expect(User.by_surname('asc')).to eq([john, michael])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        john = create(:user, :surname => 'John')
        michael = create(:user, :surname => 'Michael')

        expect(User.by_surname('desc')).to eq([michael, john])
      end
    end
  end

  describe '.by_email' do
    context 'when asc' do
      it 'sorts ascending' do
        john = create(:user, :email => 'John@fakemail.com')
        michael = create(:user, :email => 'Michael@fakemail.com')

        expect(User.by_email('asc')).to eq([john, michael])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        john = create(:user, :email => 'John@fakemail.com')
        michael = create(:user, :email => 'Michael@fakemail.com')

        expect(User.by_email('desc')).to eq([michael, john])
      end
    end
  end

  describe '.by_role' do
    context 'when asc' do
      it 'sorts ascending' do
        admin = create(:user, :role => UserRole.admin)
        user = create(:user, :role => UserRole.user)

        expect(User.by_role('asc')).to eq([admin, user])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        admin = create(:user, :role => UserRole.admin)
        user = create(:user, :role => UserRole.user)

        expect(User.by_role('desc')).to eq([user, admin])
      end
    end
  end

  describe '.by_subscription' do
    context 'when asc' do
      it 'sorts ascending' do
        nonsubscribed = create(:user, :subscription => false)
        subscribed = create(:user, :subscription => true)

        expect(User.by_subscription('asc')).to eq([nonsubscribed, subscribed])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        nonsubscribed = create(:user, :subscription => false)
        subscribed = create(:user, :subscription => true)

        expect(User.by_subscription('desc')).to eq([subscribed, nonsubscribed])
      end
    end
  end
  
end