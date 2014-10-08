require 'rails_helper'

RSpec.describe Report, :type => :model do

  describe 'factory' do
    it 'has a valid factory' do
      report = build(:report)

      expect(report).to be_valid
    end

    context 'trait "existing_references"' do
      it 'has a valid factory' do
        create(:user, :reviewer)
        create(:shop)
        report = build(:report, :existing_references)

        expect(report).to be_valid
      end
    end
  end

  describe '.with_user' do
    context 'when report for user exists' do
      it 'returns corresponding report' do
        user = create(:user, :reviewer)
        report = create(:report, :user => user)

        expect(Report.with_user(user.id)).to eq([report])
      end
    end

    context 'when report for user is absent' do
      it 'returns empty result' do
        report = create(:report)

        expect(Report.with_user(0)).to be_blank
      end
    end
  end

  describe '.with_shop' do
    context 'when report for shop exists' do
      it 'returns corresponding report' do
        shop = create(:shop)
        report = create(:report, :shop => shop)

        expect(Report.with_shop(shop.id)).to eq([report])
      end
    end

    context 'when report for shop is absent' do
      it 'returns empty result' do
        report = create(:report)

        expect(Report.with_shop(0)).to be_blank
      end
    end
  end

  describe '.with_score_from' do
    context 'when report for score exists' do
      it 'returns corresponding report' do
        report = create(:report, :score => 4)

        expect(Report.with_score_from(3)).to eq([report])
      end
    end

    context 'when report for score is absent' do
      it 'returns empty result' do
        report = create(:report, :score => 3)

        expect(Report.with_score_from(4)).to be_blank
      end
    end
  end

  describe '.with_score_to' do
    context 'when report for score exists' do
      it 'returns corresponding report' do
        report = create(:report, :score => 4)

        expect(Report.with_score_to(4)).to eq([report])
      end
    end

    context 'when report for score is absent' do
      it 'returns empty result' do
        report = create(:report, :score => 3)

        expect(Report.with_score_to(2)).to be_blank
      end
    end
  end

  describe '.with_date_from' do
    context 'when report for date exists' do
      it 'returns corresponding report' do
        report = create(:report)

        expect(Report.with_date_from(Date.today)).to eq([report])
      end
    end

    context 'when report for date is absent' do
      it 'returns empty result' do
        report = create(:report, :created_at => Time.now - 1.day)

        expect(Report.with_date_from(Date.today)).to be_blank
      end
    end
  end

  describe '.with_date_to' do
    context 'when report for date exists' do
      it 'returns corresponding report' do
        report = create(:report)

        expect(Report.with_date_to(Date.today + 1.day)).to eq([report])
      end
    end

    context 'when report for date is absent' do
      it 'returns empty result' do
        report = create(:report, :score => 3)

        expect(Report.with_date_to(Date.today)).to be_blank
      end
    end
  end

  describe '.by_created_at' do
    context 'when asc' do
      it 'sorts ascending' do
        current = create(:report, :created_at => Time.now)
        previous = create(:report, :created_at => Time.now - 1.hour)

        expect(Report.by_created_at('asc')).to eq([previous, current])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        current = create(:report, :created_at => Time.now)
        previous = create(:report, :created_at => Time.now - 1.hour)

        expect(Report.by_created_at('desc')).to eq([current, previous])
      end
    end
  end

  describe '.by_score' do
    context 'when asc' do
      it 'sorts ascending' do
        score_3 = create(:report, :score => 3)
        score_4 = create(:report, :score => 4)

        expect(Report.by_score('asc')).to eq([score_3, score_4])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        score_3 = create(:report, :score => 3)
        score_4 = create(:report, :score => 4)

        expect(Report.by_score('desc')).to eq([score_4, score_3])
      end
    end
  end

  describe '.by_user' do
    context 'when asc' do
      it 'sorts ascending' do
        report_john = create(:report, :user => create(:user, :reviewer, :name => 'John', :surname => 'Ola'))
        report_steve = create(:report, :user => create(:user, :reviewer, :name => 'Steve', :surname => 'Doe'))

        expect(Report.by_user('asc')).to eq([report_john, report_steve])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        report_john = create(:report, :user => create(:user, :reviewer, :name => 'John', :surname => 'Ola'))
        report_steve = create(:report, :user => create(:user, :reviewer, :name => 'Steve', :surname => 'Doe'))

        expect(Report.by_user('desc')).to eq([report_steve, report_john])
      end
    end
  end

  describe '.by_shop' do
    context 'when asc' do
      it 'sorts ascending' do
        report_boston = create(:report,
          :shop => create(:shop, :city => create(:city, :name => 'Boston'), :address => 'TV 141')
          )
        report_new_york = create(:report,
          :shop => create(:shop, :city => create(:city, :name => 'New York'), :address => 'AB 11')
          )

        expect(Report.by_shop('asc')).to eq([report_boston, report_new_york])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        report_boston = create(:report,
          :shop => create(:shop, :city => create(:city, :name => 'Boston'), :address => 'TV 141')
          )
        report_new_york = create(:report,
          :shop => create(:shop, :city => create(:city, :name => 'New York'), :address => 'AB 11')
          )

        expect(Report.by_shop('desc')).to eq([report_new_york, report_boston])
      end
    end
  end

  describe '#structured' do
    context 'empty report' do
      it 'return empty hash' do
        report = create(:report)

        expect(report.structured).to eq({})
      end
    end

    context 'with elements' do
      it 'returns report grouped by category' do
        report = create(:report)
        category = create(:report_structure_category)
        element = create(:report_element, :category => category, :report => report)

        expect(report.structured).to eq({category => [element]})
      end
    end
  end

  describe '#update_scores' do
    it 'updates shop score' do
      shop = create(:shop)
      report = create(:report, :shop => shop, :score => 2.1)

      expect(shop.score).to eq(2.1)
    end

    context 'when all shops have score' do
      it 'updates dealer score' do
        dealer = create(:dealer)
        shop1 = create(:shop, :dealer => dealer)
        shop2 = create(:shop, :dealer => dealer)
        report = create(:report, :shop => shop1, :score => 2)
        report = create(:report, :shop => shop2, :score => 4)

        dealer.reload
        expect(dealer.score).to eq(3)
      end
    end

    context 'when some shop have no score' do
      it 'updates dealer score' do
        dealer = create(:dealer)
        shop1 = create(:shop, :dealer => dealer, :score => nil)
        shop2 = create(:shop, :dealer => dealer, :score => nil)
        report = create(:report, :shop => shop1, :score => 2)
        
        dealer.reload
        expect(dealer.score).to eq(2)
      end
    end
  end
end
