class CreateUserDevices < ActiveRecord::Migration
  def change
    create_table :user_devices do |t|
      t.references :user, index: true
      t.string :device_id
      t.timestamp :created_at
    end
  end
end
