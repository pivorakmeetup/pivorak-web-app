class Event < ApplicationRecord
  extend FriendlyId
  mount_uploader :cover, EventCoverUploader
  friendly_id :title, use: :slugged

  DEFAULT_LIMIT = 50

  has_many :talks
  has_many :visit_requests

  validates :title,  presence: true
end
