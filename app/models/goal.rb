# frozen_string_literal: true

class Goal < ApplicationRecord
  include ::Searchable

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title,  presence: true
  validates :amount, presence: true, numericality: true
end
