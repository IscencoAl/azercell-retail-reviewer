require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe EmployeeWorkposition, :type => :model do
  it_behaves_like "soft deletable", :employee_workposition, EmployeeWorkposition

  describe "factory" do
    it "is valid" do
      employee_workposition = create(:employee_workposition)

      expect(employee_workposition).to be_valid
    end

    context "trait 'deleted'" do
      it "is valid" do
        employee_workposition = create(:employee_workposition, :deleted)

        expect(employee_workposition).to be_valid
      end
    end
    
    context 'trait "invalid"' do
      it 'has an invalid factory' do
        employee_workposition = build(:employee_workposition, :invalid)

        expect(employee_workposition).not_to be_valid
      end
    end    
  end

  describe '.with_name' do
    context 'when part of name exists' do
      it 'returns corresponding employee_workposition' do
        employee_workposition = create(:employee_workposition, :name => 'John')

        ['oh', 'oHn', 'joh', 'John'].each do |name_part|
          expect(EmployeeWorkposition.with_name(name_part)).to eq([employee_workposition])
        end
      end
    end

    context 'when part of name is absent' do
      it 'returns empty result' do
        employee_workposition = create(:employee_workposition, :name => 'John')

        ['a', 'on', 'jh', 'Johns'].each do |name_part|
          expect(EmployeeWorkposition.with_name(name_part)).to eq([])
        end
      end
    end
  end

  describe '.with_is_deleted' do
    context 'when true' do
      it 'returns deleted shop_type' do
        employee_workposition = create(:employee_workposition, :deleted)

        expect(EmployeeWorkposition.with_is_deleted(true)).to eq([employee_workposition])
      end
    end

    context 'when is_deleted is nil' do
      it 'returns empty result' do
        employee_workposition = create(:employee_workposition, :deleted)

        expect(EmployeeWorkposition.with_is_deleted(nil)).to eq([])
      end
    end

    context 'when is_deleted is ""' do
      it 'returns empty result' do
        employee_workposition = create(:employee_workposition, :deleted)

        expect(EmployeeWorkposition.with_is_deleted("")).to eq([])
      end
    end

    context 'when is_deleted is false' do
      it 'returns empty result' do
        employee_workposition = create(:employee_workposition, :deleted)

        expect(EmployeeWorkposition.with_is_deleted(false)).to eq([])
      end
    end
  end
end
