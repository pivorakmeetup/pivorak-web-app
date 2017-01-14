class VisitRequest < ApplicationRecord
  PENDING   = :pending
  APPROVED  = :approved
  CANCELED  = :canceled

  enum status: [PENDING, APPROVED, CANCELED]

  validates :event_id, :user_id, presence: true

  belongs_to :event
  belongs_to :user

  scope :main_list,    -> { where(waiting_list: false) }
  scope :waiting_list, -> { where(waiting_list: true)  }
  scope :final,        -> { approved.main_list }

  def main_list!
    update(waiting_list: false)
  end

  def waiting_list!
    update(waiting_list: true)
  end
end
