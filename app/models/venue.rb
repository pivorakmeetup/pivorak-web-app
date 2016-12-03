class Venue < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events

  validates :name, presence: true
  validates :address, presence: true
  validates :maps_url, presence: true
end