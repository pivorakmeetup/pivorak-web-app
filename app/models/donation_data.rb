# frozen_string_literal: true
class DonationData < ApplicationRecord
  validates :order_reference, uniqueness: true, presence: true
end
