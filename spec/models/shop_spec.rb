require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe Shop, :type => :model do
  
  it_behaves_like "soft deletable", :shop, Shop

  describe 'factory' do
    it 'has a valid factory' do
      shop = build(:shop)

      expect(shop).to be_valid
    end

    context 'trait "deleted"' do
      it 'has a valid factory' do
        shop = build(:shop, :deleted)

        expect(shop).to be_valid 
      end
    end

    context 'trait "invalid"' do
      it 'has an invalid factory' do
        shop = build(:shop, :invalid)

        expect(shop).not_to be_valid
      end
    end
  end

  describe '.with_type' do
    context 'when type exists' do
      it 'returns corresponding shop' do
        type = create(:shop_type)
        shop = create(:shop, :type => type)

        expect(Shop.with_type(type)).to eq([shop])
      end
    end

    context 'when type is absent' do
      it 'returns empty result' do
        shop = create(:shop)

        expect(Shop.with_type(0)).to eq([])
      end
    end
  end

  describe '.with_city' do
    context 'when with_city exists' do
      it 'returns corresponding shop' do

        city = create(:city)
        shop = create(:shop, :city => city)

        expect(Shop.with_city(city)).to eq([shop])
      end
    end

    context 'when city is absent' do
      it 'returns empty result' do
        shop = create(:shop)

        expect(Shop.with_city(0)).to eq([])
      end
    end
  end

  describe '.with_dealer' do
    context 'when with_dealer exists' do
      it 'returns corresponding shop' do

        dealer = create(:dealer)
        shop = create(:shop, :dealer => dealer)

        expect(Shop.with_dealer(dealer)).to eq([shop])
      end
    end

    context 'when city is absent' do
      it 'returns empty result' do
        shop = create(:shop)

        expect(Shop.with_dealer(0)).to eq([])
      end
    end
  end

  describe '.with_user' do
    context 'when with_user exists' do
      it 'returns corresponding shop' do

        user = create(:user)
        shop = create(:shop, :user => user)

        expect(Shop.with_user(user)).to eq([shop])
      end
    end

    context 'when city is absent' do
      it 'returns empty result' do
        shop = create(:shop)

        expect(Shop.with_dealer(0)).to eq([])
      end
    end
  end

   describe '.with_is_deleted' do
    context 'when true' do
      it 'returns deleted shop' do
        shop = create(:shop, :deleted)

        expect(Shop.with_is_deleted(true)).to eq([shop])
      end
    end

    context 'when is_deleted is nil' do
      it 'returns empty result' do
        shop = create(:shop, :deleted)

        expect(Shop.with_is_deleted(nil)).to eq([])
      end
    end

    context 'when is_deleted is ""' do
      it 'returns empty result' do
        shop = create(:shop, :deleted)

        expect(Shop.with_is_deleted("")).to eq([])
      end
    end

    context 'when is_deleted is false' do
      it 'returns empty result' do
        shop = create(:shop, :deleted)

        expect(Shop.with_is_deleted(false)).to eq([])
      end
    end
  end

    describe '.with_address' do
    context 'when part of address exists' do
      it 'returns corresponding shop' do
        shop = create(:shop, :address => 'John')

        ['oh', 'oHn', 'joh', 'John'].each do |name_part|
          expect(Shop.with_address(name_part)).to eq([shop])
        end
      end
    end

    context 'when part of name is absent' do
      it 'returns empty result' do
        shop = create(:shop, :address => 'John')

        ['a', 'on', 'jh', 'Johns'].each do |name_part|
          expect(Shop.with_address(name_part)).to eq([])
        end
      end
    end
  end

  describe '.by_type' do
    context 'when asc' do
      it 'sorts ascending' do
        a = create(:shop, :type => create(:shop_type, :name => "A"))
        b = create(:shop, :type => create(:shop_type, :name => "B"))

        expect(Shop.by_type('asc')).to eq([a, b])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        a = create(:shop, :type => create(:shop_type, :name => "A"))
        b = create(:shop, :type => create(:shop_type, :name => "B"))

        expect(Shop.by_type('desc')).to eq([b, a])
      end
    end
  end

  describe '.by_user' do
    context 'when asc' do
      it 'sorts ascending' do
        a = create(:shop, :user => create(:user, :reviewer, :name => "A"))
        b = create(:shop, :user => create(:user, :reviewer, :name => "B"))

        expect(Shop.by_user('asc')).to eq([a, b])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        a = create(:shop, :user => create(:user, :reviewer, :name => "A"))
        b = create(:shop, :user => create(:user, :reviewer, :name => "B"))

        expect(Shop.by_user('desc')).to eq([b, a])
      end
    end
  end

  describe '.by_dealer' do
    context 'when asc' do
      it 'sorts ascending' do
        a = create(:shop, :dealer => create(:dealer, :name => "A"))
        b = create(:shop, :dealer => create(:dealer, :name => "B"))

        expect(Shop.by_dealer('asc')).to eq([a, b])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        a = create(:shop, :dealer => create(:dealer, :name => "A"))
        b = create(:shop, :dealer => create(:dealer, :name => "B"))

        expect(Shop.by_dealer('desc')).to eq([b, a])
      end
    end
  end

  describe '.by_address' do
    context 'when asc' do
      it 'sorts ascending' do
        a = create(:shop, :city => create(:city, :name => "A"), :address => 'D')
        b = create(:shop, :city => create(:city, :name => "B"), :address => 'C')

        expect(Shop.by_address('asc')).to eq([a, b])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        a = create(:shop, :city => create(:city, :name => "A"), :address => 'D')
        b = create(:shop, :city => create(:city, :name => "B"), :address => 'C')

        expect(Shop.by_address('desc')).to eq([b, a])
      end
    end
  end

  describe '.by_score' do
    context 'when asc' do
      it 'sorts ascending' do
        a = create(:shop)
        create(:report, :shop => a, :score => 1)
        b = create(:shop)
        create(:report, :shop => b, :score => 2)

        expect(Shop.by_score('asc')).to eq([a, b])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        a = create(:shop)
        create(:report, :shop => a, :score => 1)
        b = create(:shop)
        create(:report, :shop => b, :score => 2)

        expect(Shop.by_score('desc')).to eq([b, a])
      end
    end
  end

  describe '#full_address' do
    it 'returns full address' do
      city = create(:city, :name => "Gorod")
      shop = build(:shop, :city => city, :address => 'Doe')

      expect(shop.full_address).to eql('Gorod, Doe')
    end
  end

  describe '#full_address_was' do
    it 'returns old full address' do
      city = create(:city, :name => "Gorod")
      shop = create(:shop, :city => city, :address => 'Doe')

      shop.address = 'hristo'

      expect(shop.full_address_was).to eql('Gorod, Doe')
    end
  end

  describe '#score' do
    context 'without reports' do
      it 'returns nil' do
        shop = create(:shop)

        expect(shop.score).to be_nil
      end
    end

    context 'with reports' do
      it 'returns last report score' do
        shop = create(:shop)
        report = create(:report, :shop => shop, :score => 3)

        expect(shop.score).to eq(3)
      end
    end
  end

  describe '#last_report' do
    context 'without reports' do
      it 'returns nil' do
        shop = create(:shop)

        expect(shop.last_report).to be_nil
      end
    end

    context 'with reports' do
      it 'returns last report' do
        shop = create(:shop)
        report = create(:report, :shop => shop)

        expect(shop.last_report).to eq(report)
      end
    end
  end

end
