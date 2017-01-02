class Event < ApplicationRecord
  extend FriendlyId
  include Publishable

  DEFAULT_LIMIT = 50

  mount_uploader :cover, EventCoverUploader

  friendly_id :title, use: :slugged

  has_many :talks
  has_many :visit_requests

  validates :title,  presence: true
end
