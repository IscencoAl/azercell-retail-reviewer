class UserDevice < ActiveRecord::Base
  validates :user_id, :presence => true, :uniqueness => { :message => "is already associated with another device" }
  validates :device_id, :presence => true, :uniqueness => { :message => "is already associated with another user" }
  validate  :total_count

  belongs_to :user

  private

  def total_count
    errors.add(:base, "Maximum devices count is achieved") if UserDevice.count >= 1
  end
end
