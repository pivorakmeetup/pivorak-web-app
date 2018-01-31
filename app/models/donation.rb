class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates :currency, presence: true
  validates :amount, presence: true, numericality: true
  validates :payment_id, uniqueness: true, presence: true
end
