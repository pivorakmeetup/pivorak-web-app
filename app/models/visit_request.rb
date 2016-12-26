class VisitRequest < ApplicationRecord
  PENDING = :pending
  APPROVED = :approved
  CANCELED = :canceled

  enum status: [PENDING, APPROVED, CANCELED]

  validates :event_id, :user_id, :status, presence: true

  belongs_to :event
  belongs_to :user
end
