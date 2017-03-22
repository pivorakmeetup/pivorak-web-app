class Event < ApplicationRecord
  include ::Searchable
  include Publishable

  extend FriendlyId

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
  has_many :approved_visit_requests, -> { approved }, class_name: :VisitRequest
  has_many :pending_visit_requests,  -> { pending },  class_name: :VisitRequest

  has_many :visitors,                                       through: :visit_requests, source: :user
  has_many :verified_visitors, -> { merge(User.verified) }, through: :visit_requests, source: :user
  has_many :newbie_visitors,   -> { merge(User.newbies) },  through: :visit_requests, source: :user

  scope :display, -> { where.not(status: PLANNED) }

  validates :title, :limit_total, :limit_verified, presence: true
  validates_with LimitsValidator

  def self.upcoming
    where(published: true).order('started_at').last
  end

  def limit_newbies
    limit_total - limit_verified
  end
end
