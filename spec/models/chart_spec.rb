require 'rails_helper'

RSpec.describe Chart, :type => :model do

  describe '.reports_score' do
    context 'with no reports' do
      it 'returns blank hash' do
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

end