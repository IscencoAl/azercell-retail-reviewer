class Report < ActiveRecord::Base
  include Modules::Filterable
  include Modules::Sortable

  validates :user, :presence => true
  validates :shop, :presence => true
  validates :latitude, :presence => true
  validates :longitude, :presence => true
  validates :score, :presence => true
  validates :created_at, :presence => true

  belongs_to :user
  belongs_to :shop

  has_one :city, :through => :shop

  has_many :elements, :class_name => 'ReportElement'
  has_many :photos, :class_name => 'ReportPhoto', :dependent => :destroy

  scope :with_user, -> (user) { where(:user => user) }
  scope :with_shop, -> (shop) { where(:shop => shop) }
  scope :with_score_from, -> (score) { where('score >= ?', score) }
  scope :with_score_to, -> (score) { where('score <= ?', score) }

  scope :by_created_at, -> (dir) { order("created_at #{dir}") }
  scope :by_score, -> (dir) { order("score #{dir}") }
  scope :by_user, -> (dir) { joins(:user).order("users.name #{dir}, users.surname #{dir}") }
  scope :by_shop, -> (dir) { joins(:city).order("cities.name #{dir}, shops.address #{dir}") }

  def structured
    elements.group_by(&:category)
  end
end
