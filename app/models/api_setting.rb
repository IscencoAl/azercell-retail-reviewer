class ApiSetting < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :value, :presence => true

  def self.change_version(name, value=nil)
    return false if name.blank?

    api_setting = ApiSetting.where(:name => name).first_or_create
    api_setting.value = value || SecureRandom.uuid
    api_setting.save

    return true
  end

end
