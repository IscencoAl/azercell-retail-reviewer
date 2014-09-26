require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe Dealer, :type => :model do

  it_behaves_like "soft deletable", :dealer, Dealer

  describe "factory" do
    it "is valid" do
      dealer = create(:dealer)

      expect(dealer).to be_valid
    end

    context "trait 'deleted'" do
      it "is valid" do
        dealer = create(:dealer, :deleted)

        expect(dealer).to be_valid
      end
    end
    
    context 'trait "invalid"' do
      it 'has an invalid factory' do
        dealer = build(:dealer, :invalid)

        expect(dealer).not_to be_valid
      end
    end    
  end

  describe '.with_name' do
    context 'when part of name exists' do
      it 'returns corresponding dealer' do
        dealer = create(:dealer, :name => 'John')

        ['oh', 'oHn', 'joh', 'John'].each do |name_part|
          expect(Dealer.with_name(name_part)).to eq([dealer])
        end
      end
    end

    context 'when part of name is absent' do
      it 'returns empty result' do
        dealer = create(:dealer, :name => 'John')

        ['a', 'on', 'jh', 'Johns'].each do |name_part|
          expect(Dealer.with_name(name_part)).to eq([])
        end
      end
    end
  end

  describe '.with_contact_name' do
    context 'when part of contact_name exists' do
      it 'returns corresponding dealer' do
        dealer = create(:dealer, :contact_name => 'John')

        ['oh', 'oHn', 'joh', 'John'].each do |cont_name|
          expect(Dealer.with_contact_name(cont_name)).to eq([dealer])
        end
      end
    end

    context 'when part of name is absent' do
      it 'returns empty result' do
        dealer = create(:dealer, :contact_name => 'John')

        ['a', 'on', 'jh', 'Johns'].each do |cont_name|
          expect(Dealer.with_contact_name(cont_name)).to eq([])
        end
      end
    end
  end


  describe '.with_is_deleted' do
    context 'when true' do
      it 'returns deleted dealer' do
        dealer = create(:dealer, :deleted)

        expect(Dealer.with_is_deleted(true)).to eq([dealer])
      end
    end

    context 'when is_deleted is nil' do
      it 'returns empty result' do
        dealer = create(:dealer, :deleted)

        expect(Dealer.with_is_deleted(nil)).to eq([])
      end
    end

    context 'when is_deleted is ""' do
      it 'returns empty result' do
        dealer = create(:dealer, :deleted)

        expect(Dealer.with_is_deleted("")).to eq([])
      end
    end

    context 'when is_deleted is false' do
      it 'returns empty result' do
        dealer = create(:dealer, :deleted)

        expect(Dealer.with_is_deleted(false)).to eq([])
      end
    end
  end

  describe '.by_name' do
    context 'when asc' do
      it 'sorts ascending' do
        center = create(:dealer, :name => 'Center')
        west = create(:dealer, :name => 'West')

        expect(Dealer.by_name('asc')).to eq([center, west])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        center = create(:dealer, :name => 'Center')
        west = create(:dealer, :name => 'West')

        expect(Dealer.by_name('desc')).to eq([west, center])
      end
    end
  end

  describe '.by_contact_name' do
    context 'when asc' do
      it 'sorts ascending' do
        center = create(:dealer, :contact_name => 'Center')
        west = create(:dealer, :contact_name => 'West')

        expect(Dealer.by_contact_name('asc')).to eq([center, west])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        center = create(:dealer, :contact_name => 'Center')
        west = create(:dealer, :contact_name => 'West')

        expect(Dealer.by_contact_name('desc')).to eq([west, center])
      end
    end
  end

  describe '.by_score' do
    context 'when asc' do
      it 'sorts ascending' do
        dealer1 = create(:dealer, :score => 1)
        dealer2 = create(:dealer, :score => 2)

        expect(Dealer.by_score('asc')).to eq([dealer1, dealer2])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        dealer1 = create(:dealer, :score => 1)
        dealer2 = create(:dealer, :score => 2)

        expect(Dealer.by_score('desc')).to eq([dealer2, dealer1])
      end
    end
  end

  describe 'delete shops' do
    it 'deletes all shops' do
      dealer = create(:dealer)
      shop = create(:shop, :dealer => dealer)

      dealer.delete_shops
      dealer.reload

      expect(dealer.shops).to be_blank
    end
  end
  
end