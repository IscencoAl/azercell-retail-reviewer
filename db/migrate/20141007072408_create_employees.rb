class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.references :shop, index: true
      t.references :employee_workposition, index: true
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
