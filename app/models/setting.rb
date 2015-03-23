class Setting < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :value, :presence => true

  after_update :change_shop_structure_version

  SHOPS_STRUCTURE_VERSION = 'shops_structure_version'
  REPORT_STRUCTURE_VERSION = 'report_structure_version'
  REVIEW_ASSOCIATED_SHOPS = 'review_associated_shops'
  MAX_USER_DEVICES_COUNT = 'max_user_devices_count'


  def self.change_version(name, value=nil)
    return false if name.blank?

    api_setting = Setting.where(:name => name).first_or_create
    api_setting.value = value || SecureRandom.uuid
    api_setting.save
  end

  def self.max_user_devices_count
    Setting.find_by_name(Setting::MAX_USER_DEVICES_COUNT).value.to_i
  end

  private

  def change_shop_structure_version
    Setting.change_version(SHOPS_STRUCTURE_VERSION) if name == REVIEW_ASSOCIATED_SHOPS
  end

end
