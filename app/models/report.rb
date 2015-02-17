class Report < ActiveRecord::Base
  include Modules::Filterable
  include Modules::Sortable

  validates :user, :presence => true
  validates :shop, :presence => true
  validates :latitude, :presence => true
  validates :longitude, :presence => true
  validates :score, :presence => true
  validates :created_at, :presence => true

  belongs_to :user, -> { with_deleted }
  belongs_to :shop, -> { with_deleted }

  has_one :city, :through => :shop
  has_one :dealer, :through => :shop

  has_many :elements, :class_name => 'ReportElement'
  has_many :photos, :class_name => 'ReportPhoto'

  accepts_nested_attributes_for :elements

  scope :with_user, -> (user) { where(:user => user) }
  scope :with_shop, -> (shop) { where(:shop => shop) }
  scope :with_score_from, -> (score) { where('score >= ?', score) }
  scope :with_score_to, -> (score) { where('score <= ?', score) }
  scope :with_date_from, -> (date) { where('created_at >= ?', date) }
  scope :with_date_to, -> (date) { where('created_at <= ?', date) }
  scope :with_dealer, -> (dealer) { joins(:shop).where(:shops => {:dealer_id => dealer}) }

  scope :by_created_at, -> (dir) { order("created_at #{dir}") }
  scope :by_score, -> (dir) { order("score #{dir}") }
  scope :by_user, -> (dir) { joins(:user).order("users.name #{dir}, users.surname #{dir}") }
  scope :by_shop, -> (dir) { joins(:city).order("cities.name #{dir}, shops.address #{dir}") }

  MAX_SCORE = 5

  after_create :update_scores

  def structured
    ReportStructureCategory.unscoped do
      elements.group_by(&:category)
    end
  end

  def update_scores
    self.shop.update_attribute(:score, self.score)

    avg_score = dealer.shops.average(:score)
    dealer.update_attribute(:score, avg_score)
  end
end
