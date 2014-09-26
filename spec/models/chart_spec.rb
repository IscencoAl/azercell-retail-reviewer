require 'rails_helper'

RSpec.describe Chart, :type => :model do

  describe '.reports_score' do
    context 'with no reports' do
      it 'returns blank array' do
        expect(Chart.reports_score()).to eq([])
      end
    end

    context 'with reports' do
      it 'returns scores' do
        create(:report, :score => 3, :created_at => Time.now.change(:day => 10, :month => 3))
        create(:report, :score => 5, :created_at => Time.now.change(:day => 11, :month => 3))

        expect(Chart.reports_score()).to eq([['Date', 'Score'], ['10 Mar', 3.0], ['11 Mar', 5.0]])
      end

      context 'with limit' do
        it 'returns limited scores' do
          create(:report, :score => 5, :created_at => Time.now.change(:day => 9, :month => 3))
          create(:report, :score => 3, :created_at => Time.now.change(:day => 10, :month => 3))
          create(:report, :score => 5, :created_at => Time.now.change(:day => 11, :month => 3))

          expect(Chart.reports_score(nil, 2)).to eq([['Date', 'Score'], ['10 Mar', 3.0], ['11 Mar', 5.0]]) 
        end
      end

      context 'with shop' do
        it 'returns scores for shop' do
          shop = create(:shop)
          create(:report, :score => 5, :created_at => Time.now.change(:day => 9, :month => 3))
          create(:report, :score => 3, :created_at => Time.now.change(:day => 10, :month => 3), :shop => shop)
          create(:report, :score => 5, :created_at => Time.now.change(:day => 11, :month => 3), :shop => shop)

          expect(Chart.reports_score({:shop => shop.id})).to eq([['Date', 'Score'], ['10 Mar', 3.0], ['11 Mar', 5.0]]) 
        end
      end
    end
  end

  describe '.reports_count' do
    context 'with no reports' do
      it 'returns blank array' do
        expect(Chart.reports_count()).to eq([])
      end
    end

    context 'with reports' do
      it 'returns count' do
        create(:report, :created_at => Time.now)
        create(:report, :created_at => Time.now)

        expect(Chart.reports_count()[-1][1]).to eq(2)
      end

      context 'with day limit' do
        it 'returns limited cunt' do
          create(:report, :created_at => Time.now)
          create(:report, :created_at => Time.now)
          create(:report, :created_at => Time.now)

          reports_count = [['Date', 'Count'], [(Time.now - 1.day).strftime("%d %b"), 0], [Time.now.strftime("%d %b"), 3]]

          expect(Chart.reports_count(nil, 1)).to eq(reports_count) 
        end
      end

      context 'with user' do
        it 'returns scores for user' do
          user = create(:user)
          create(:report, :created_at => Time.now)
          create(:report, :created_at => Time.now, :user => user)
          create(:report, :created_at => Time.now, :user => user)

          expect(Chart.reports_count({:user => user.id})[-1][1]).to eq(2) 
        end
      end
    end
  end

end