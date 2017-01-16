class Event < ApplicationRecord
  include ::Searchable

  extend FriendlyId
  include Publishable

  PLANNED       = :planned
  REGISTRATION  = :registration
  LIVE          = :live
  PASSED        = :passed
  DEFAULT_LIMIT = 50

  mount_uploader :cover, EventCoverUploader

  friendly_id :title, use: :slugged

  enum status: [PLANNED, REGISTRATION, LIVE, PASSED]

  belongs_to :venue

  has_many :talks
  has_many :visit_requests
  has_many :visitors, through: :visit_requests, source: :user

  scope :display, -> { where(status: [REGISTRATION, PASSED]) }

  validates :title, :limit_total, :limit_verified, presence: true
  validates_with LimitsValidator

  def limit_newbies
    limit_total - limit_verified
  end
end
