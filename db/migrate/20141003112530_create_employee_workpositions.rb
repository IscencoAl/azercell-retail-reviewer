class CreateEmployeeWorkpositions < ActiveRecord::Migration
  def change
    create_table :employee_workpositions do |t|
      t.string :name
      t.boolean :is_deleted
    end
  end
end
