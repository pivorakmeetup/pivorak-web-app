# frozen_string_literal: true

class Venue < ApplicationRecord
  include ::Searchable

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events, dependent: :nullify

  validates :name,    presence: true
  validates :address, presence: true
  validates :map_url, presence: true
end
