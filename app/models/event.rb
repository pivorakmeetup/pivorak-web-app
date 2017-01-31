class Event < ApplicationRecord
  include ::Searchable

  extend FriendlyId
  include Publishable

  PLANNED       = :planned
  REGISTRATION  = :registration
  CONFIRMATION  = :confirmation
  LIVE          = :live
  PASSED        = :passed
  DEFAULT_LIMIT = 50

  mount_uploader :cover, EventCoverUploader

  DEFAULT_STARTED_AT_HOURS = 18
  DEFAULT_FINISHED_AT_HOURS = 22

  friendly_id :title, use: :slugged

  enum status: [PLANNED, REGISTRATION, CONFIRMATION, LIVE, PASSED]

  belongs_to :venue

  has_many :talks
  has_many :visit_requests
  has_many :visitors, through: :visit_requests, source: :user

  scope :display, -> { where.not(status: PLANNED) }

  validates :title, :limit_total, :limit_verified, presence: true
  validates_with LimitsValidator

  def limit_newbies
    limit_total - limit_verified
  end
end
