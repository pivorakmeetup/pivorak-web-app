# frozen_string_literal: true

class VisitRequest < ApplicationRecord
  include ::Searchable

  PENDING   = :pending
  APPROVED  = :approved
  CANCELED  = :canceled
  CONFIRMED = :confirmed
  REFUSED   = :refused

  enum status: [PENDING, APPROVED, CANCELED, CONFIRMED, REFUSED]

  validates :event_id, :user_id, presence: true

  belongs_to :event
  belongs_to :user

  delegate :full_name, to: :user

  scope :main_list,    -> { where(waiting_list: false) }
  scope :waiting_list, -> { where(waiting_list: true)  }
  scope :final,        -> { where(status: [APPROVED, CONFIRMED]).main_list }
  scope :used,         -> { where(visited: true) }

  def main_list!
    update(waiting_list: false)
  end

  def waiting_list!
    update(waiting_list: true)
  end

  def final_decision?
    confirmed? || refused?
  end

  def checked_in?
    checked_in_at.present?
  end
end
