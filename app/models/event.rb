# frozen_string_literal: true

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

  enum status: { PLANNED => 0, REGISTRATION => 1, CONFIRMATION => 2, LIVE => 3, PASSED => 4 }

  belongs_to :venue

  has_many :talks, dependent: :nullify
  has_many :visit_requests, dependent: :nullify

  %i[approved pending final confirmed used].each do |scope_name|
    has_many :"#{scope_name}_visit_requests", -> { send(scope_name) }, class_name: 'VisitRequest', dependent: :nullify,
             inverse_of: :event
  end

  has_many :visitors,                                       through: :visit_requests, source: :user
  has_many :verified_visitors, -> { merge(User.verified) }, through: :visit_requests, source: :user
  has_many :newbie_visitors,   -> { merge(User.newbies) },  through: :visit_requests, source: :user

  scope :visible, -> { where.not(status: PLANNED) }
  scope :ordered_by_start, -> { order(:started_at) }

  validate :venue_existing
  validates :title, :limit_total, :limit_verified, presence: true
  validate :total_less_verified

  def self.upcoming
    where(published: true).where.not(status: [PASSED]).ordered_by_start.last
  end

  def self.current
    find_by(
      'started_at >= :beginning_of_day AND finished_at < :end_of_day',
      beginning_of_day: Time.current.beginning_of_day,
      end_of_day:       Time.current.end_of_day
    )
  end

  def limit_newbies
    limit_total - limit_verified
  end

  private

  def venue_existing
    errors.add(:venue_id, :missing, message: I18n.t('venues.errors.missing')) if venue.blank? && !planned?
  end

  def total_less_verified
    return unless limit_total && limit_verified

    return if limit_total >= limit_verified

    errors.add :limit_verified, I18n.t('errors.total_less_verified')
  end
end
