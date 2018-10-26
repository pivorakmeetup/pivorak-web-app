class Event < ApplicationRecord
  include ::Searchable
  include Publishable

  extend FriendlyId

  PLANNED       = :planned
  REGISTRATION  = :registration
  CONFIRMATION  = :confirmation
  LIVE          = :live
  PASSED        = :passed

  mount_uploader :cover, EventCoverUploader
  friendly_id :title, use: :slugged

  enum status: [PLANNED, REGISTRATION, CONFIRMATION, LIVE, PASSED]

  belongs_to :venue

  has_many :talks
  has_many :visit_requests

  %i(approved pending final confirmed used).each do |scope_name|
    has_many :"#{scope_name}_visit_requests", -> { send(scope_name) }, class_name: 'VisitRequest'
  end

  has_many :visitors,                                       through: :visit_requests, source: :user
  has_many :verified_visitors, -> { merge(User.verified) }, through: :visit_requests, source: :user
  has_many :newbie_visitors,   -> { merge(User.newbies) },  through: :visit_requests, source: :user

  scope :display, -> { where.not(status: PLANNED) }

  validates :title, :limit_total, :limit_verified, presence: true
  validates_with LimitsValidator

  def self.upcoming
    where(published: true).order('started_at').last
  end

  def self.current
    find_by('started_at >= :beginning_of_day AND finished_at < :end_of_day', beginning_of_day: Time.zone.now.beginning_of_day, end_of_day: Time.now.end_of_day)
  end

  def limit_newbies
    limit_total - limit_verified
  end
end
