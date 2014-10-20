require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe Employee, :type => :model do
  it_behaves_like "soft deletable", :employee, Employee

  describe "factory" do
    it "is valid" do
      employee = create(:employee)

      expect(employee).to be_valid
    end

    context "trait 'deleted'" do
      it "is valid" do
        employee = create(:employee, :deleted)

        expect(employee).to be_valid
      end
    end
    
    context 'trait "invalid"' do
      it 'has an invalid factory' do
        employee = build(:employee, :invalid)

        expect(employee).not_to be_valid
      end
    end    
  end

  describe '.with_name' do
    context 'when part of name exists' do
      it 'returns corresponding dealer' do
        employee = create(:employee, :name => 'John')

        ['oh', 'oHn', 'joh', 'John'].each do |name_part|
          expect(Employee.with_name(name_part)).to eq([employee])
        end
      end
    end

    context 'when part of name is absent' do
      it 'returns empty result' do
        employee = create(:employee, :name => 'John')

        ['a', 'on', 'jh', 'Johns'].each do |name_part|
          expect(Employee.with_name(name_part)).to eq([])
        end
      end
    end
  end

  describe '.with_shop' do
    context 'when shop exists' do
      it 'returns corresponding employee' do
        shop = create(:shop)
        employee = create(:employee, :shop => shop)

        expect(Employee.with_shop(shop)).to eq([employee])
      end
    end

    context 'when shop is absent' do
      it 'returns empty result' do
        employee = create(:employee)

        expect(Employee.with_shop(0)).to eq([])
      end
    end
  end

  describe '.with_employee_workposition' do
    context 'when workposition exists' do
      it 'returns corresponding employee' do
        employee_workposition = create(:employee_workposition)
        employee = create(:employee, :employee_workposition => employee_workposition)

        expect(Employee.with_employee_workposition(employee_workposition)).to eq([employee])
      end
    end

    context 'when workposition is absent' do
      it 'returns empty result' do
        employee = create(:employee)

        expect(Employee.with_employee_workposition(0)).to eq([])
      end
    end
  end

  describe '.with_is_deleted' do
    context 'when true' do
      it 'returns deleted employee' do
        employee = create(:employee, :deleted)

        expect(Employee.with_is_deleted(true)).to eq([employee])
      end
    end

    context 'when is_deleted is nil' do
      it 'returns empty result' do
        employee = create(:employee, :deleted)

        expect(Employee.with_is_deleted(nil)).to eq([])
      end
    end

    context 'when is_deleted is ""' do
      it 'returns empty result' do
        employee = create(:employee, :deleted)

        expect(Employee.with_is_deleted("")).to eq([])
      end
    end

    context 'when is_deleted is false' do
      it 'returns empty result' do
        employee = create(:employee, :deleted)

        expect(Employee.with_is_deleted(false)).to eq([])
      end
    end
  end

  describe '.by_name' do
    context 'when asc' do
      it 'sorts ascending' do
        anna = create(:employee, :name => 'anna')
        jora = create(:employee, :name => 'jora')

        expect(Employee.by_name('asc')).to eq([anna, jora])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        anna = create(:employee, :name => 'anna')
        jora = create(:employee, :name => 'jora')

        expect(Employee.by_name('desc')).to eq([jora, anna])
      end
    end
  end

  describe '.by_shop' do
    context 'when asc' do
      it 'sorts ascending' do
        center = create(:employee, :shop => create(:shop, {:address => "Hristo-Botev", :city => create(:city, {:name =>"Chisinau"})}))
        nord = create(:employee, :shop => create(:shop, {:address => "Aeroport", :city => create(:city, {:name =>"Drochia"})}))

        expect(Employee.by_shop('asc')).to eq([center, nord])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        center = create(:employee, :shop => create(:shop, {:address => "Hristo-Botev", :city => create(:city, {:name =>"Chisinau"})}))
        nord = create(:employee, :shop => create(:shop, {:address => "Aeroport", :city => create(:city, {:name =>"Drochia"})}))

        expect(Employee.by_shop('desc')).to eq([nord, center])
      end
    end
  end

 describe '.by_employee_workposition' do
    context 'when asc' do
      it 'sorts ascending' do
        center = create(:employee, :employee_workposition => create(:employee_workposition, {:name => 'Center'}))
        west = create(:employee, :employee_workposition => create(:employee_workposition, {:name => 'West'}))

        expect(Employee.by_employee_workposition('asc')).to eq([center, west])
      end
    end

    context 'when desc' do
      it 'sorts descending' do
        center = create(:employee, :employee_workposition => create(:employee_workposition, {:name => 'Center'}))
        west = create(:employee, :employee_workposition => create(:employee_workposition, {:name => 'West'}))

        expect(Employee.by_employee_workposition('desc')).to eq([west, center])
      end
    end
  end
end
