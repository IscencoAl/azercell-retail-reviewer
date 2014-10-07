class AddDealerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dealer_id, :integer, index: true
  end
end
