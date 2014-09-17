class ReportPhoto < ActiveRecord::Base
  mount_uploader :photo, PhotosUploader

  validates :report, :presence => true

  belongs_to :report
end
