require 'rails_helper'

RSpec.shared_examples "soft deletable" do |factory, model|
  describe ".deleted" do
    context "when deleted records are apsent" do
      it "is blank" do
        deleted_records = model.deleted

        expect(deleted_records).to be_blank
      end
    end

    context "when deleted records exist" do
      it "is not blank" do
        create(factory, :deleted)
        deleted_records = model.deleted

        expect(deleted_records).not_to be_blank
      end

      it "returns only deleted obj" do
        create(factory)
        is_deleted = create(factory, :deleted)

        deleted_records = model.deleted.to_a
        expect(deleted_records).to be_eql([is_deleted])

      end
    end
  end

  describe ".with_deleted" do
    context "when records are apsent" do
      it "is blank" do
        records = model.with_deleted

        expect(records).to be_blank
      end
    end

    context "when records exist" do
      it "is not blank" do
        record1 = create(factory, :deleted)
        record2 = create(factory)

        records = model.with_deleted

        expect(Set.new(records)).to eq(Set.new([record1, record2]))
      end
    end
  end

  describe "#soft_delete" do
    context "for existing record" do
      it "set is_deleted to false" do
        record = create(factory)
        record.soft_delete

        expect(record.is_deleted).to be_eql(true)
      end
    end

    context "for deleted record" do
      it "set is_deleted to true" do
        record = create(factory, :deleted)
        record.soft_delete

        expect(record.is_deleted).to be_eql(true)
      end
    end
  end

  describe "#restore" do
    context "for existing record" do
      it "set is_deleted to false" do
        record = create(factory)
        record.restore

        expect(record.is_deleted).to be_eql(false)
      end
    end

    context "for deleted record" do
      it "set is deleted to true" do
        record = create(factory, :deleted)
        record.restore

        expect(record.is_deleted).to be_eql(false)
      end
    end

  end
end
