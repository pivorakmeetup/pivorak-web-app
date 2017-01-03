class Event < ApplicationRecord
  extend FriendlyId
  include Publishable

  DEFAULT_LIMIT = 50
  PLANNED       = :planned
  REGISTRATION  = :registration
  PASSED        = :passed

  mount_uploader :cover, EventCoverUploader

  friendly_id :title, use: :slugged

  enum status: [PLANNED, REGISTRATION, PASSED]

  has_many :talks
  has_many :visit_requests
  belongs_to :venue

  scope :display, -> { where(status: [REGISTRATION, PASSED]) }

  validates :title,  presence: true
end
