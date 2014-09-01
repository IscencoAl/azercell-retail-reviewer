class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.references :user_role, index: true
      t.boolean :subscription, :default => false
      t.boolean :is_deleted, :default => true

      t.timestamps
    end
  end
end
