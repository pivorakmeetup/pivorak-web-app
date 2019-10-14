# frozen_string_literal: true

class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates :amount, presence: true, numericality: true
  validates :payment_id, uniqueness: true, presence: true
end
