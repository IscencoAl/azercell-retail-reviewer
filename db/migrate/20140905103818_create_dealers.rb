class CreateDealers < ActiveRecord::Migration
  def change
    create_table :dealers do |t|
      t.string :name
      t.string :contact_name
      t.string :phone_number
      t.string :email
      t.boolean :is_deleted
    end
  end
end
