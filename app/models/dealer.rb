class Dealer < ActiveRecord::Base
  include Modules::SoftDelete
  include Modules::Filterable
  include Modules::Sortable

  validates :name,  :presence => true, :uniqueness => true

  has_many :shops

  scope :with_name, -> (name) { where("name ilike ?", "%#{name}%") }
  scope :with_contact_name, -> (contact_name) { where("contact_name ilike ?", "%#{contact_name}%") }
  scope :with_is_deleted, -> (is_deleted) { deleted unless is_deleted.blank? }

  scope :by_name, -> (dir) { order("name #{dir}") }
  scope :by_contact_name, -> (dir) { order("contact_name #{dir}") }
  scope :by_score, -> (dir) { order("score #{dir} nulls last")}

  before_soft_delete :delete_shops
  def delete_shops
    shops.each do |shop|
      shop.soft_delete
    end
  end

  after_soft_delete -> { self.touch }
  after_save -> { self.touch }
  after_touch :change_shop_structure_version
  def change_shop_structure_version
    Setting.change_version('shops_structure_version')
  end

end
