class City < ActiveRecord::Base
  include Modules::SoftDelete

  validates :name,  :presence => true, :uniqueness => true
  validates :region,  :presence => true

  belongs_to :region
  
end
